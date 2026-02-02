# QA Checklist Template

Copy this template to create manual QA checklists for testing features before release.

**Output Location:** `docs/test/backend/[module_name]/qa_checklist.md` or `docs/test/[frontend]/qa_checklist.md`

---

# [FEATURE_NAME] QA Checklist

**Feature:** [Feature Name]
**Version:** 1.0
**Status:** Draft | In Testing | Passed | Failed
**Last Updated:** [YYYY-MM-DD]
**FSD Reference:** `docs/fsd/[module]/[submodule]/spec.md`
**Tester:** [QA Name]
**Test Date:** [YYYY-MM-DD]

---

## Source Code Reference

> **Purpose:** This section tracks which version of the source code this QA checklist was created for.
> When code changes, compare against this reference to identify areas needing re-testing.

| Field | Value |
|-------|-------|
| Repository | `[repository-url]` |
| Branch | `[branch-name]` |
| Commit Hash | `[full-commit-hash]` |
| Commit Date | `[YYYY-MM-DD HH:MM:SS]` |
| Commit Message | `[commit-message-summary]` |

**Source Files Covered:**

```
[List the source code files covered by this QA checklist]
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

## Test Summary

| Category | Total | Passed | Failed | Blocked | Not Run |
|----------|-------|--------|--------|---------|---------|
| Functional | [N] | [N] | [N] | [N] | [N] |
| UI/UX | [N] | [N] | [N] | [N] | [N] |
| Security | [N] | [N] | [N] | [N] | [N] |
| Performance | [N] | [N] | [N] | [N] | [N] |
| **Total** | **[N]** | **[N]** | **[N]** | **[N]** | **[N]** |

**Overall Result:** ✅ PASS | ❌ FAIL | ⚠️ PASS WITH ISSUES

---

## Test Environment

| Item | Value |
|------|-------|
| Environment | Development / Staging / UAT / Production |
| URL | [URL] |
| Browser | [Browser + Version] |
| Device | [Device/OS] |
| Build Version | [Version/Commit] |
| Test Date | [YYYY-MM-DD] |

---

## 1. Functional Testing

### 1.1 [Feature Area 1]

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 1.1.1 | [Test item description] | [Expected result] | ⬜ | |
| 1.1.2 | [Test item description] | [Expected result] | ⬜ | |
| 1.1.3 | [Test item description] | [Expected result] | ⬜ | |

**Status Legend:** ✅ Pass | ❌ Fail | ⚠️ Pass with Issues | 🚫 Blocked | ⬜ Not Run

---

### 1.2 CRUD Operations

| # | Operation | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------|-----------------|--------|-------|
| 1.2.1 | CREATE | Create new record with valid data | Record created successfully | ⬜ | |
| 1.2.2 | CREATE | Create with missing required fields | Validation error displayed | ⬜ | |
| 1.2.3 | CREATE | Create with duplicate unique field | Duplicate error displayed | ⬜ | |
| 1.2.4 | READ | View list with data | Data displayed correctly | ⬜ | |
| 1.2.5 | READ | View list with no data | Empty state displayed | ⬜ | |
| 1.2.6 | READ | View single record details | All fields displayed correctly | ⬜ | |
| 1.2.7 | UPDATE | Update record with valid data | Record updated successfully | ⬜ | |
| 1.2.8 | UPDATE | Update with invalid data | Validation error displayed | ⬜ | |
| 1.2.9 | DELETE | Delete single record | Record removed, confirmation shown | ⬜ | |
| 1.2.10 | DELETE | Delete with confirmation cancel | Record not deleted | ⬜ | |

---

### 1.3 Search and Filtering

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 1.3.1 | Search with valid keyword | Matching results displayed | ⬜ | |
| 1.3.2 | Search with no matches | "No results" message shown | ⬜ | |
| 1.3.3 | Search with special characters | Handled correctly, no errors | ⬜ | |
| 1.3.4 | Filter by [filter field] | Results filtered correctly | ⬜ | |
| 1.3.5 | Multiple filters combined | All filters applied correctly | ⬜ | |
| 1.3.6 | Clear filters | All results shown | ⬜ | |

---

### 1.4 Pagination

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 1.4.1 | First page load | First N items displayed | ⬜ | |
| 1.4.2 | Navigate to next page | Next set of items displayed | ⬜ | |
| 1.4.3 | Navigate to previous page | Previous set displayed | ⬜ | |
| 1.4.4 | Change page size | Page reloads with new size | ⬜ | |
| 1.4.5 | Last page with partial data | Correct number of items shown | ⬜ | |

---

### 1.5 Business Rules

| # | Rule ID | Test Item | Expected Result | Status | Notes |
|---|---------|-----------|-----------------|--------|-------|
| 1.5.1 | BR-001 | [Business rule description] | [Expected behavior] | ⬜ | |
| 1.5.2 | BR-002 | [Business rule description] | [Expected behavior] | ⬜ | |
| 1.5.3 | BR-003 | [Business rule description] | [Expected behavior] | ⬜ | |

---

## 2. UI/UX Testing

### 2.1 Layout and Design

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 2.1.1 | Page layout matches design | Layout consistent with mockups | ⬜ | |
| 2.1.2 | Responsive design (desktop) | Layout correct at 1920x1080 | ⬜ | |
| 2.1.3 | Responsive design (tablet) | Layout correct at 768x1024 | ⬜ | |
| 2.1.4 | Responsive design (mobile) | Layout correct at 375x667 | ⬜ | |
| 2.1.5 | Color scheme consistency | Colors match design system | ⬜ | |
| 2.1.6 | Typography consistency | Fonts match design system | ⬜ | |
| 2.1.7 | Spacing and alignment | Elements properly aligned | ⬜ | |

---

### 2.2 Navigation

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 2.2.1 | Menu navigation | All menu items navigate correctly | ⬜ | |
| 2.2.2 | Breadcrumb navigation | Breadcrumbs show correct path | ⬜ | |
| 2.2.3 | Back button behavior | Returns to previous page | ⬜ | |
| 2.2.4 | Deep link access | Direct URL access works | ⬜ | |
| 2.2.5 | Active state indication | Current page highlighted | ⬜ | |

---

### 2.3 Forms and Inputs

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 2.3.1 | Required field indicators | Required fields marked with * | ⬜ | |
| 2.3.2 | Input placeholder text | Helpful placeholder shown | ⬜ | |
| 2.3.3 | Field validation on blur | Validation triggers on blur | ⬜ | |
| 2.3.4 | Error message display | Clear error messages shown | ⬜ | |
| 2.3.5 | Success message display | Success notification shown | ⬜ | |
| 2.3.6 | Form reset/cancel | Form clears on cancel | ⬜ | |
| 2.3.7 | Tab order | Logical tab navigation | ⬜ | |
| 2.3.8 | Autofocus on first field | First input focused on load | ⬜ | |

---

### 2.4 Loading States

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 2.4.1 | Page loading indicator | Spinner/skeleton shown | ⬜ | |
| 2.4.2 | Button loading state | Button disabled, spinner shown | ⬜ | |
| 2.4.3 | Table loading state | Table skeleton/spinner shown | ⬜ | |
| 2.4.4 | No double submit | Prevents duplicate submissions | ⬜ | |

---

### 2.5 Error States

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 2.5.1 | 404 page | Custom 404 page displayed | ⬜ | |
| 2.5.2 | 500 error handling | Friendly error message shown | ⬜ | |
| 2.5.3 | Network error | "Connection error" message | ⬜ | |
| 2.5.4 | Session timeout | Redirect to login | ⬜ | |

---

## 3. Security Testing

### 3.1 Authentication

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 3.1.1 | Login with valid credentials | Login successful | ⬜ | |
| 3.1.2 | Login with invalid credentials | Generic error message | ⬜ | |
| 3.1.3 | Access protected page without login | Redirect to login | ⬜ | |
| 3.1.4 | Session persistence | Session survives refresh | ⬜ | |
| 3.1.5 | Logout functionality | Session cleared, redirect to login | ⬜ | |
| 3.1.6 | Password masking | Password field masked | ⬜ | |

---

### 3.2 Authorization

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 3.2.1 | Role-based menu visibility | Only permitted menu items shown | ⬜ | |
| 3.2.2 | Role-based button visibility | Action buttons per permissions | ⬜ | |
| 3.2.3 | Direct URL access (unauthorized) | 403 error or redirect | ⬜ | |
| 3.2.4 | API call (unauthorized) | 403 response | ⬜ | |
| 3.2.5 | Company data isolation | Only own company data visible | ⬜ | |
| 3.2.6 | Store data isolation | Only permitted store data visible | ⬜ | |

---

### 3.3 Data Security

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 3.3.1 | XSS prevention | Script tags not executed | ⬜ | |
| 3.3.2 | SQL injection prevention | SQL syntax not interpreted | ⬜ | |
| 3.3.3 | Sensitive data in URL | No sensitive data in URL params | ⬜ | |
| 3.3.4 | Sensitive data in logs | No passwords/tokens logged | ⬜ | |
| 3.3.5 | HTTPS enforcement | All traffic over HTTPS | ⬜ | |

---

## 4. Performance Testing

### 4.1 Page Load Performance

| # | Test Item | Target | Actual | Status | Notes |
|---|-----------|--------|--------|--------|-------|
| 4.1.1 | Initial page load | < 3s | [X]s | ⬜ | |
| 4.1.2 | Subsequent page load | < 2s | [X]s | ⬜ | |
| 4.1.3 | Time to interactive | < 3s | [X]s | ⬜ | |
| 4.1.4 | First contentful paint | < 1.5s | [X]s | ⬜ | |

---

### 4.2 Operation Performance

| # | Test Item | Target | Actual | Status | Notes |
|---|-----------|--------|--------|--------|-------|
| 4.2.1 | Search response time | < 1s | [X]s | ⬜ | |
| 4.2.2 | Form submission | < 2s | [X]s | ⬜ | |
| 4.2.3 | Large data load (1000+ rows) | < 3s | [X]s | ⬜ | |
| 4.2.4 | Export operation | < 5s | [X]s | ⬜ | |

---

## 5. Compatibility Testing

### 5.1 Browser Compatibility

| Browser | Version | Status | Notes |
|---------|---------|--------|-------|
| Chrome | Latest | ⬜ | |
| Firefox | Latest | ⬜ | |
| Safari | Latest | ⬜ | |
| Edge | Latest | ⬜ | |

---

### 5.2 Device Compatibility (if mobile)

| Device | OS Version | Status | Notes |
|--------|------------|--------|-------|
| Android Phone | 12+ | ⬜ | |
| Android Tablet | 12+ | ⬜ | |
| [Specific device] | [Version] | ⬜ | |

---

## 6. Regression Testing

### 6.1 Critical Paths

| # | Test Item | Expected Result | Status | Notes |
|---|-----------|-----------------|--------|-------|
| 6.1.1 | [Critical path 1] | [Expected behavior] | ⬜ | |
| 6.1.2 | [Critical path 2] | [Expected behavior] | ⬜ | |
| 6.1.3 | [Critical path 3] | [Expected behavior] | ⬜ | |

---

### 6.2 Previously Reported Issues

| # | Issue ID | Description | Fixed | Status | Notes |
|---|----------|-------------|-------|--------|-------|
| 6.2.1 | [BUG-001] | [Issue description] | [Version] | ⬜ | |
| 6.2.2 | [BUG-002] | [Issue description] | [Version] | ⬜ | |

---

## 7. Edge Cases and Boundary Testing

| # | Test Item | Input | Expected Result | Status | Notes |
|---|-----------|-------|-----------------|--------|-------|
| 7.1 | Empty input | "" | Validation error | ⬜ | |
| 7.2 | Maximum length | [Max chars] | Accepted or truncated | ⬜ | |
| 7.3 | Minimum value | [Min value] | Accepted | ⬜ | |
| 7.4 | Maximum value | [Max value] | Accepted | ⬜ | |
| 7.5 | Special characters | `<script>alert('xss')</script>` | Escaped/rejected | ⬜ | |
| 7.6 | Unicode characters | `日本語 עברית` | Handled correctly | ⬜ | |
| 7.7 | Very long text | [1000+ chars] | Handled correctly | ⬜ | |
| 7.8 | Negative numbers | `-1` | Error or accepted per spec | ⬜ | |
| 7.9 | Decimal precision | `0.001` | Correct precision | ⬜ | |

---

## 8. Defects Found

| # | Severity | Summary | Steps to Reproduce | Status |
|---|----------|---------|-------------------|--------|
| D-001 | [Critical/High/Medium/Low] | [Summary] | [Steps] | Open/Fixed |
| D-002 | [Severity] | [Summary] | [Steps] | Open/Fixed |

---

## 9. Sign-Off

### 9.1 Test Completion

| Criterion | Status |
|-----------|--------|
| All P0 tests passed | ⬜ |
| All P1 tests passed | ⬜ |
| No open Critical defects | ⬜ |
| No open High defects | ⬜ |
| Performance targets met | ⬜ |
| Security tests passed | ⬜ |

### 9.2 Approval

| Role | Name | Signature | Date |
|------|------|-----------|------|
| QA Tester | | | |
| QA Lead | | | |
| Product Owner | | | |

---

## 10. Notes and Observations

[Add any additional observations, recommendations, or concerns here]

---

## Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | [Author] | Initial creation |
