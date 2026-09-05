#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOW_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REPOSITORY_ROOT="$(git -C "$WORKFLOW_DIR" rev-parse --show-toplevel)"
WORKFLOW_PATH="${WORKFLOW_DIR#"$REPOSITORY_ROOT"/}"
FILE_1="$WORKFLOW_DIR/1-vibe-coding-foundation.md"
FILE_2="$WORKFLOW_DIR/2-vibe-coding-bootstrap.md"
FILE_3="$WORKFLOW_DIR/3-vibe-coding-session-closeout.md"
FILE_4="$WORKFLOW_DIR/4-vibe-coding-continuation.md"
README_FILE="$WORKFLOW_DIR/README.md"
SERVER_README="$WORKFLOW_DIR/server/README.md"
CANONICAL_PREFIX="https://github.com/Razva/public/blob/main/"
CANONICAL_PATTERN='https://github\.com/Razva/public/blob/main/'

fail() {
  printf 'Workflow integrity validation failed: %s\n' "$1" >&2
  exit 1
}

for required_file in "$FILE_1" "$FILE_2" "$FILE_3" "$FILE_4" "$README_FILE" "$SERVER_README"; do
  [[ -f "$required_file" ]] ||
    fail "required workflow file is missing from the working tree: ${required_file#"$REPOSITORY_ROOT"/}"
done

require_matching_sets() {
  local actual="$1"
  local expected="$2"
  local failure_message="$3"

  [[ "$actual" == "$expected" ]] || fail "$failure_message"
}

TRACKED_WORKFLOW_PATHS="$(
  git -C "$REPOSITORY_ROOT" ls-files -- "$WORKFLOW_PATH" |
    sort -u
)"

while IFS= read -r tracked_workflow_path; do
  [[ -n "$tracked_workflow_path" ]] || continue
  [[ -e "$REPOSITORY_ROOT/$tracked_workflow_path" ]] ||
    fail "tracked workflow path is missing from the working tree: $tracked_workflow_path"
done <<< "$TRACKED_WORKFLOW_PATHS"

TRACKED_MARKDOWN_PATHS="$(
  printf '%s\n' "$TRACKED_WORKFLOW_PATHS" |
    grep '\.md$' || true
)"

is_tracked_path() {
  local repository_path="$1"
  printf '%s\n' "$TRACKED_WORKFLOW_PATHS" | grep -Fqx -- "$repository_path"
}

TRACKED_PROFILES="$(
  git -C "$REPOSITORY_ROOT" ls-files -- "$WORKFLOW_PATH/profiles/*.md" |
    sed "s#^$WORKFLOW_PATH/##" |
    sort -u
)"

FILE_2_PROFILES="$(
  sed -n '/^## 10\./,/^## 11\./p' "$FILE_2" |
    grep -oE "${CANONICAL_PATTERN}${WORKFLOW_PATH}/profiles/[A-Za-z0-9._/-]+\.md" |
    sed "s#^${CANONICAL_PATTERN}${WORKFLOW_PATH}/##" |
    sort -u || true
)"

README_PROFILES="$(
  sed -n '/^## Conditional References$/,/^## /p' "$README_FILE" |
    grep -oE 'profiles/[A-Za-z0-9._/-]+\.md' |
    sort -u || true
)"

require_matching_sets "$TRACKED_PROFILES" "$FILE_2_PROFILES" \
  "File 2's technology-profile registry does not match tracked profiles."
require_matching_sets "$TRACKED_PROFILES" "$README_PROFILES" \
  "README's profile overview does not match tracked profiles."

TRACKED_REFERENCES="$(
  git -C "$REPOSITORY_ROOT" ls-files -- "$WORKFLOW_PATH/references/*.md" |
    sed "s#^$WORKFLOW_PATH/##" |
    sort -u
)"

FILE_1_REFERENCES="$(
  sed -n '/^## 23\./,/^## 24\./p' "$FILE_1" |
    grep -oE "${CANONICAL_PATTERN}${WORKFLOW_PATH}/references/[A-Za-z0-9._/-]+\.md" |
    sed "s#^${CANONICAL_PATTERN}${WORKFLOW_PATH}/##" |
    sort -u || true
)"

FILE_2_REFERENCES="$(
  sed -n '/^## 8\./,/^## 9\./p' "$FILE_2" |
    grep -oE "${CANONICAL_PATTERN}${WORKFLOW_PATH}/references/[A-Za-z0-9._/-]+\.md" |
    sed "s#^${CANONICAL_PATTERN}${WORKFLOW_PATH}/##" |
    sort -u || true
)"

README_REFERENCES="$(
  sed -n '/^## Conditional References$/,/^## /p' "$README_FILE" |
    grep -oE 'references/[A-Za-z0-9._/-]+\.md' |
    sort -u || true
)"

require_matching_sets "$TRACKED_REFERENCES" "$FILE_1_REFERENCES" \
  "File 1's conditional-reference registration does not match tracked references."
require_matching_sets "$TRACKED_REFERENCES" "$FILE_2_REFERENCES" \
  "File 2's conditional-reference registration does not match tracked references."
require_matching_sets "$TRACKED_REFERENCES" "$README_REFERENCES" \
  "README's conditional-reference overview does not match tracked references."

SERVER_ENTRYPOINT="$WORKFLOW_PATH/server/README.md"
SERVER_SETUP="$WORKFLOW_PATH/server/setup.md"
is_tracked_path "$SERVER_ENTRYPOINT" || fail "server guidance entry point is not tracked."
is_tracked_path "$SERVER_SETUP" || fail "server setup guide is not tracked."

sed -n '/^## 34\./,/^## 35\./p' "$FILE_1" |
  grep -Fq -- "$CANONICAL_PREFIX$SERVER_ENTRYPOINT" ||
  fail "File 1 does not register the canonical server guidance entry point."

sed -n '/^## 13\./,/^## 14\./p' "$FILE_2" |
  grep -Fq -- "$CANONICAL_PREFIX$SERVER_SETUP" ||
  fail "File 2 does not register the canonical server setup guide."

sed -n '/^## Optional Development Server Guidance$/,/^## /p' "$README_FILE" |
  grep -Fq -- '(server/README.md)' ||
  fail "README does not register the server guidance entry point."

TRACKED_SERVER_GUIDES="$(
  git -C "$REPOSITORY_ROOT" ls-files -- "$WORKFLOW_PATH/server/*.md" |
    sed "s#^$WORKFLOW_PATH/##" |
    grep -v '^server/README\.md$' |
    sort -u || true
)"

SERVER_README_GUIDES="$(
  grep -oE '\]\([A-Za-z0-9._/-]+\.md(#[^)]*)?\)' "$SERVER_README" |
    sed -E 's/^\]\(([^#)]+)(#[^)]*)?\)$/\1/' |
    grep -v '^\.\./' |
    sed 's#^#server/#' |
    sort -u || true
)"

require_matching_sets "$TRACKED_SERVER_GUIDES" "$SERVER_README_GUIDES" \
  "server/README.md does not register every tracked server guide."

for workflow_file in "$FILE_1" "$FILE_2" "$FILE_3" "$FILE_4"; do
  LINK_TARGETS="$(
    grep -oE '\]\([^)]+\)' "$workflow_file" |
      sed -E 's/^\]\((.*)\)$/\1/' || true
  )"

  while IFS= read -r target; do
    [[ -n "$target" ]] || continue
    target="${target%%#*}"
    [[ -n "$target" ]] || continue
    [[ "$target" =~ ^[A-Za-z][A-Za-z0-9+.-]*: ]] && continue
    fail "Files 1-4 require absolute links for workflow-owned resources: $target"
  done <<< "$LINK_TARGETS"
done

CANONICAL_URLS="$(
  while IFS= read -r markdown_repository_path; do
    [[ -n "$markdown_repository_path" ]] || continue
    grep -hoE "${CANONICAL_PATTERN}${WORKFLOW_PATH}/[A-Za-z0-9._/-]+" \
      "$REPOSITORY_ROOT/$markdown_repository_path" || true
  done <<< "$TRACKED_MARKDOWN_PATHS" |
    sort -u
)"

while IFS= read -r url; do
  [[ -n "$url" ]] || continue
  repository_path="${url#"$CANONICAL_PREFIX"}"
  is_tracked_path "$repository_path" || fail "canonical link does not resolve to a tracked path: $url"
done <<< "$CANONICAL_URLS"

while IFS= read -r markdown_repository_path; do
  [[ -n "$markdown_repository_path" ]] || continue
  markdown_file="$REPOSITORY_ROOT/$markdown_repository_path"
  LINK_TARGETS="$(
    grep -oE '\]\([^)]+\)' "$markdown_file" |
      sed -E 's/^\]\((.*)\)$/\1/' || true
  )"

  while IFS= read -r target; do
    [[ -n "$target" ]] || continue
    target="${target%%#*}"
    [[ -n "$target" ]] || continue
    [[ "$target" =~ ^[A-Za-z][A-Za-z0-9+.-]*: ]] && continue
    [[ "$target" == /* ]] && fail "root-relative link is not a repository path: $target"

    target_directory="$(dirname "$markdown_file")/$(dirname "$target")"
    resolved_directory="$(cd "$target_directory" 2>/dev/null && pwd -P)" ||
      fail "relative link directory does not exist: $target"
    resolved_path="$resolved_directory/$(basename "$target")"
    [[ "$resolved_path" == "$WORKFLOW_DIR"/* ]] ||
      fail "relative link escapes the workflow directory: $target"
    repository_path="${resolved_path#"$REPOSITORY_ROOT"/}"
    is_tracked_path "$repository_path" ||
      fail "relative link does not resolve to a tracked path: $target"
  done <<< "$LINK_TARGETS"
done <<< "$TRACKED_MARKDOWN_PATHS"

printf 'Workflow integrity validation passed.\n'
