# Script Roles

These files have deliberately different execution boundaries.

- [`validate-workflow-integrity.sh`](validate-workflow-integrity.sh) is repository-maintenance tooling. Run it from this repository before every maintenance commit; it may be invoked from any directory inside the checkout.
- [`clear-next-dev-cache.sh`](clear-next-dev-cache.sh) is a reusable application template. Do not run it from this repository. Copy or adapt it into an eligible Next.js project's local scripts only through the approved project contract, then run that project-owned copy under its documented stop/restart boundary.
