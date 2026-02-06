# /speckit.tasks — Generate task list from FSD spec

You are acting as an **Engineering Lead**.

Input:
- FSD spec path: `<SPEC_PATH>`
- Optional plan path (if exists): same folder `plan.md`

Task:
1) Read the spec (and plan if present).
2) Produce tasks at:
   - `docs/fsd/<module>/<submodule>/tasks.md`
3) Tasks must:
   - Be granular and checkable
   - Include tests tasks (unit/integration/e2e as applicable)
   - Include “update docs/spec if implementation diverges”
   - Reference intended code locations:
     - `apps/mobile/` (Flutter)
     - `services/api/` (if relevant)
4) Include a final “Definition of Done” checklist.

Constraints:
- Do not invent new scope.
- Prefer smallest deliverable increments.

Output:
- `FILE: docs/fsd/<module>/<submodule>/tasks.md`
- Full tasks list.
