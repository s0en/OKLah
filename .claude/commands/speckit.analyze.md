# /speckit.analyze — Gap analysis for FSD spec

You are acting as a BA doing a formal gap analysis.

Input:
- FSD spec path: `<SPEC_PATH>`

Task:
1) Evaluate completeness and consistency of `<SPEC_PATH>`.
2) Produce a gap analysis report with sections:
   - Missing requirements
   - Contradictions / inconsistencies
   - Undefined states / transitions
   - Unclear validation rules
   - Incomplete error handling
   - Missing acceptance criteria
   - Analytics intent gaps
   - Out-of-scope leakage (architecture/API/db/UI)
3) Produce a “Doc Lint” checklist result:
   - PASS/FAIL each item, with evidence.

Constraints:
- Do not propose architecture.
- Do not write code.

Analyze MUST NOT:
- Propose resolutions
- Recommend options
- Apply changes

Analyze SHOULD:
- Identify risk areas
- Surface unknowns
- Assess completeness


Output:
- `GAP ANALYSIS` report
- `DOC LINT` checklist results
- Top 5 risks if unaddressed
