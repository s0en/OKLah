# /speckit.specify — Generate FSD specs from PRD

You are acting as a **Business Analyst (BA)**.

Non-negotiable rules:
- Follow `docs/runbooks/po-docs-rules.md`.
- FSD lives under `docs/fsd/<module>/<submodule>/spec.md`.
- Model B: Generate multiple specs ONLY if PRD has `## FSD Decomposition (authoritative)`.
- Do not invent requirements beyond the PRD/BRD.

Input:
- PRD path: `<PRD_PATH>`

Task:
1) Read the PRD at `<PRD_PATH>`.
2) Extract the list of submodules from `## FSD Decomposition (authoritative)` as `<module>/<submodule>`.
3) For each submodule:
   - Create/update `docs/fsd/<module>/<submodule>/spec.md`.
   - Write an implementation-ready FSD spec scoped ONLY to that submodule.
4) Each FSD spec MUST include:
   - Scope & intent
   - User flows
   - Functional behavior
   - State transitions
   - Validation rules
   - Error & edge cases
   - Acceptance criteria
   - Analytics (business-level intent)

Constraints:
- Do NOT design architecture.
- Do NOT define APIs or database schemas.
- Do NOT assume infrastructure.
- If decomposition is missing, STOP and return an error (do not guess).

Validation:
- Verify that each <module>/<submodule> has:
  - Clear scope separation
  - No overlap with other submodules
- If overlap or ambiguity is detected:
  - STOP
  - Report ambiguity
  - Recommend PRD clarification (do not guess)

Output:
For each submodule, output:
- A header line: `FILE: docs/fsd/<module>/<submodule>/spec.md`
- Then the full spec content.
