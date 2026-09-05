#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOW_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
REPOSITORY_ROOT="$(git -C "$WORKFLOW_DIR" rev-parse --show-toplevel)"
WORKFLOW_PATH="${WORKFLOW_DIR#"$REPOSITORY_ROOT"/}"
FILE_2="$WORKFLOW_DIR/2-vibe-coding-bootstrap.md"
README_FILE="$WORKFLOW_DIR/README.md"
CANONICAL_PREFIX="https://github.com/Razva/public/blob/main/"

fail() {
  printf 'Workflow integrity validation failed: %s\n' "$1" >&2
  exit 1
}

mapfile -t TRACKED_PROFILES < <(
  git -C "$REPOSITORY_ROOT" ls-files -- "$WORKFLOW_PATH/profiles/*.md" |
    sed "s#^$WORKFLOW_PATH/##" |
    sort -u
)

mapfile -t FILE_2_PROFILES < <(
  sed -n '/^## 10\./,/^## 11\./p' "$FILE_2" |
    grep -oE "${CANONICAL_PREFIX}${WORKFLOW_PATH}/profiles/[A-Za-z0-9._/-]+\.md" |
    sed "s#^${CANONICAL_PREFIX}${WORKFLOW_PATH}/##" |
    sort -u
)

mapfile -t README_PROFILES < <(
  sed -n '/^## Conditional References$/,/^## /p' "$README_FILE" |
    grep -oE 'profiles/[A-Za-z0-9._/-]+\.md' |
    sort -u
)

profile_set() {
  printf '%s\n' "$@"
}

[[ "$(profile_set "${TRACKED_PROFILES[@]}")" == "$(profile_set "${FILE_2_PROFILES[@]}")" ]] ||
  fail "File 2's technology-profile registry does not match tracked profiles."

[[ "$(profile_set "${TRACKED_PROFILES[@]}")" == "$(profile_set "${README_PROFILES[@]}")" ]] ||
  fail "README's profile overview does not match tracked profiles."

mapfile -t TRACKED_WORKFLOW_PATHS < <(
  git -C "$REPOSITORY_ROOT" ls-files -- "$WORKFLOW_PATH"
)

is_tracked_path() {
  local repository_path="$1"
  printf '%s\n' "${TRACKED_WORKFLOW_PATHS[@]}" | grep -Fqx -- "$repository_path"
}

while IFS= read -r url; do
  repository_path="${url#"$CANONICAL_PREFIX"}"
  is_tracked_path "$repository_path" || fail "canonical link does not resolve to a tracked path: $url"
done < <(
  grep -RhoE "${CANONICAL_PREFIX}${WORKFLOW_PATH}/[A-Za-z0-9._/-]+" "$WORKFLOW_DIR" --include='*.md' |
    sort -u
)

while IFS= read -r markdown_repository_path; do
  markdown_file="$REPOSITORY_ROOT/$markdown_repository_path"
  while IFS= read -r target; do
    target="${target%%#*}"
    [[ -n "$target" ]] || continue
    [[ "$target" =~ ^[A-Za-z][A-Za-z0-9+.-]*: ]] && continue
    [[ "$target" == /* ]] && fail "root-relative link is not a repository path: $target"

    resolved_path="$(realpath -m -- "$(dirname -- "$markdown_file")/$target")"
    [[ "$resolved_path" == "$WORKFLOW_DIR"/* ]] || fail "relative link escapes the workflow directory: $target"
    repository_path="${resolved_path#"$REPOSITORY_ROOT"/}"
    is_tracked_path "$repository_path" || fail "relative link does not resolve to a tracked path: $target"
  done < <(
    grep -oE '\]\([^)]+\)' "$markdown_file" |
      sed -E 's/^\]\((.*)\)$/\1/' || true
  )
done < <(
  git -C "$REPOSITORY_ROOT" ls-files -- "$WORKFLOW_PATH/*.md" "$WORKFLOW_PATH/**/*.md"
)

printf 'Workflow integrity validation passed.\n'
