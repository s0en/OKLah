# FSD Reconciliation Template

Use this template to document discrepancies between the **Old FSD** (human-written specifications) and **Current Code** (production implementation).

---

## Document Information

| Field | Value |
|-------|-------|
| Module | [Module Name] |
| Old FSD File | `resources/old-fsd/[filename].md` |
| New FSD File | `docs/fsd/module_XX_name/` |
| Reconciliation Date | YYYY-MM-DD |
| Reconciled By | [Name] |
| Status | Draft / In Review / Approved |

---

## Source Code Reference

> **Purpose:** This section tracks which version of the source code was used for this reconciliation.
> When code changes, compare against this reference to identify what needs re-verification.

| Field | Value |
|-------|-------|
| Repository | `[repository-url]` |
| Branch | `[branch-name]` |
| Commit Hash | `[full-commit-hash]` |
| Commit Date | `[YYYY-MM-DD HH:MM:SS]` |
| Commit Message | `[commit-message-summary]` |

**Files Analyzed:**

```
[List the source code files that were analyzed]
- src/path/to/file1.ts
- src/path/to/file2.ts
```

**How to check for updates:**

```bash
# View commits since this reference
git log [commit-hash]..HEAD --oneline -- [relevant-paths]

# View detailed changes since reference
git diff [commit-hash]..HEAD -- [relevant-paths]
```

---

## Discrepancy Summary

| Category | Count | Critical | Needs Decision |
|----------|-------|----------|----------------|
| Business Rules | 0 | 0 | 0 |
| Field Definitions | 0 | 0 | 0 |
| Validation Logic | 0 | 0 | 0 |
| Workflow/Process | 0 | 0 | 0 |
| UI/Screen Layout | 0 | 0 | 0 |
| **Total** | **0** | **0** | **0** |

---

## Discrepancy Types

- **SPEC_OUTDATED** - Code has new features not in spec
- **CODE_DIVERGED** - Code doesn't match spec (potential bug or intentional change)
- **SPEC_MISSING** - Spec lacks detail that exists in code
- **CODE_MISSING** - Spec has feature not implemented in code
- **CONFLICT** - Spec and code contradict each other (needs decision)

---

## Discrepancy Log

### DISC-001: [Short Description]

| Field | Value |
|-------|-------|
| Type | SPEC_OUTDATED / CODE_DIVERGED / SPEC_MISSING / CODE_MISSING / CONFLICT |
| Severity | 🔴 Critical / 🟡 High / 🟢 Medium / ⚪ Low |
| Category | Business Rule / Field Definition / Validation / Workflow / UI |
| Status | Open / Resolved / Deferred |

**Old FSD Reference:**

- File: `resources/old-fsd/[filename].md`
- Section: [Section Name]
- Line: [Line Number]
- Content:
  > [Quote the relevant text from old FSD]

**Code/New FSD Reference:**

- File: `[source file path]`
- Line: [Line Number]
- Content:

  ```
  [Code snippet or new FSD text]
  ```

**Description:**
[Detailed description of the discrepancy]

**Impact Assessment:**

- [ ] Affects core functionality
- [ ] Affects user workflow
- [ ] Affects compliance/regulatory
- [ ] Data integrity concern
- [ ] Security concern

**Recommended Action:**

- [ ] Update Spec to match Code (code is correct)
- [ ] Update Code to match Spec (spec is correct)
- [ ] Needs Business Decision
- [ ] Accept as-is (intentional deviation)

**Decision:**

| Decided By | Date | Decision |
|------------|------|----------|
| [Name] | YYYY-MM-DD | [Decision made] |

**Resolution:**
[How it was resolved, with links to commits/changes]

---

### DISC-002: [Short Description]

[Copy template from DISC-001]

---

## Business Rule Comparison

### BR-001: [Rule Name from Old FSD]

| Aspect | Old FSD | Current Code | Match? |
|--------|---------|--------------|--------|
| Rule Description | [Old FSD description] | [Code behavior] | Yes/No |
| Condition | [When rule applies] | [Code condition] | Yes/No |
| Action | [Expected action] | [Actual action] | Yes/No |
| Error Message | [Expected message] | [Actual message] | Yes/No |

**Notes:** [Any observations]

---

## Field Comparison

### Screen: [Screen Name]

| Field | Old FSD | Code | Match? | Notes |
|-------|---------|------|--------|-------|
| Field Name | Type/Required | Type/Required | Yes/No | |
| Field Name | Type/Required | Type/Required | Yes/No | |

---

## Validation Rule Comparison

| Rule | Old FSD | Code | Match? | Notes |
|------|---------|------|--------|-------|
| [Validation Name] | [Expected] | [Actual] | Yes/No | |

---

## Sign-off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| BA/Analyst | | | |
| Developer | | | |
| QA | | | |
| Product Owner | | | |

---

## Change Log

| Date | Author | Changes |
|------|--------|---------|
| YYYY-MM-DD | [Name] | Initial reconciliation |
