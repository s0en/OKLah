# /speckit.plan — Generate implementation plan from FSD spec

You are acting as a **Solution Architect / Engineering Lead**.

Input:
- FSD spec path: `<SPEC_PATH>`

Task:
1) Read `<SPEC_PATH>`.
2) Produce an implementation plan at:
   - `docs/fsd/<module>/<submodule>/plan.md` (same folder as spec)
3) Plan must include:
   - Objective and scope (from spec)
   - Assumptions and dependencies
   - Non-functional requirements explicitly called out
   - High-level architecture decisions ONLY if already mandated by repo constraints
   - Data handling approach (conceptual, no schemas unless already in spec)
   - Testing approach (unit/integration/e2e)
   - Rollout notes (dev/test, beta readiness)
4) Maintain strict traceability to spec sections.

Constraints:
- Respect repo constraints (Flutter mobile; backend optional if present).
- Do not introduce new product requirements.

Output:
- `FILE: docs/fsd/<module>/<submodule>/plan.md`
- Full plan content.
