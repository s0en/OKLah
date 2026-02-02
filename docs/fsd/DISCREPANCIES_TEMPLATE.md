# Module XX: [Module Name] - Reconciliation

---

## ⚠️ ACTION REQUIRED: Business Decisions Needed

The following discrepancies require business input. Please review and fill in your response in the **📝 Business Response** sections below.

| # | Discrepancy | Severity | Your Decision Needed? | Jump to |
|---|-------------|----------|----------------------|---------|
| DISC-001 | [Brief description] | 🔴 High | ✅ Yes | [Go to DISC-001](#disc-001-title) |
| DISC-002 | [Brief description] | 🟡 Medium | ✅ Yes | [Go to DISC-002](#disc-002-title) |
| DISC-003 | [Brief description] | 🟢 Low | Optional | [Go to DISC-003](#disc-003-title) |

**How to respond:** Scroll to each 📝 section and fill in the placeholders.

---

## Document Information

| Field | Value |
|-------|-------|
| Module | [Module Name] (MOD-XX) |
| Old FSD File | `resources/old-fsd/[filename].md` |
| New FSD Folder | `docs/fsd/module_XX_name/` |
| Code File | `[source file path]` |
| Reconciliation Date | YYYY-MM-DD |
| Status | In Progress / Pending Review / Completed |

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
| Status Definitions | 0 | 0 | 0 |
| **Total** | **0** | **0** | **0** |

---

## Discrepancy Types Reference

| Type | Meaning | Action |
|------|---------|--------|
| SPEC_OUTDATED | Code has new features not in spec | Update spec |
| CODE_DIVERGED | Code doesn't match spec | Investigate - bug or intentional? |
| SPEC_MISSING | Spec lacks detail | Add to spec from code |
| CODE_MISSING | Spec has feature not in code | Was it removed? Add to backlog? |
| CONFLICT | Spec and code contradict | Needs business decision |

---

## Business Rules Verification

### BR-X: [Rule Name] ✅ VERIFIED / ❌ DISCREPANCY / ⚠️ PARTIAL

| Aspect | Old FSD (Line XXX) | Code | Match |
|--------|---------------------|------|-------|
| Rule | "[Quote from old FSD]" | `[Code reference]` | ✅ Yes / ❌ No |

**Code Evidence:**

```
// [File]:Line
[Code snippet]
```

---

## Discrepancy Log

### DISC-001: [Discrepancy Title]

| Field | Value |
|-------|-------|
| Type | CONFLICT / SPEC_OUTDATED / SPEC_MISSING / CODE_MISSING / CODE_DIVERGED |
| Severity | 🔴 High / 🟡 Medium / 🟢 Low |
| Category | Business Rule / Field Definition / Validation / Workflow / Status |
| Status | Open / Resolved / Deferred |

**Old FSD Reference:**

- File: `resources/old-fsd/[filename].md`
- Section: [Section Name]
- Line: [Line Number]
- Content:
  > "[Quote the relevant text from old FSD]"

**Code Reference:**

- File: `[source file path]`
- Line: [Line Number]
- Content:

  ```
  [Code snippet]
  ```

**Description:**
[Detailed description of the discrepancy - what differs between spec and code]

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

**Questions for Business:**

1. [Specific question 1]
2. [Specific question 2]

---

### 📝 DISC-001: Business Response

> **Please fill in the following:**

| Field | Response |
|-------|----------|
| Decided By | _[Name/Role]_ |
| Decision Date | _[YYYY-MM-DD]_ |
| Decision | _[ ] Code is correct - update spec_ / _[ ] Spec is correct - fix code_ / _[ ] Other_ |

**Explanation:**

```
[Please explain the business decision here. For example:
- Why was the decision made?
- What is the actual business requirement?
- Any historical context?]
```

**Action Items:**

- [ ] _[List any follow-up actions needed]_

---

### DISC-002: [Discrepancy Title]

_[Copy the DISC-001 template above for each additional discrepancy]_

---

## Status Mapping (if applicable)

| Old FSD Status | Code Field | Notes |
|----------------|------------|-------|
| [Status Name] | `[field = value]` | [Notes] |

---

## Reconciliation Progress

### Phase 1: Business Rules

- [ ] BR-1: [Rule name]
- [ ] BR-2: [Rule name]

### Phase 2: Field Definitions

- [ ] [Screen name] fields
- [ ] [Screen name] fields

### Phase 3: Workflows

- [ ] [Workflow name]
- [ ] [Workflow name]

---

## Next Steps

1. **Get Business Decisions** on:
   - DISC-XXX: [Brief description]
   - DISC-XXX: [Brief description]

2. **Continue Reconciliation**:
   - [Next items to compare]

---

## Change Log

| Date | Author | Changes |
|------|--------|---------|
| YYYY-MM-DD | [Name] | Initial reconciliation |
| YYYY-MM-DD | [Name] | Added business responses |
