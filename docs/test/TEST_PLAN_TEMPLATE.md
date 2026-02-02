# Test Plan Template

Copy this template to create test plans for modules or features.

**Output Location:** `docs/test/backend/[module_name]/test_plan.md` or `docs/test/[frontend]/test_plan.md`

---

# [MODULE_NAME] Test Plan

**Module:** [Module Name]
**Version:** 1.0
**Status:** Draft | Review | Approved
**Last Updated:** [YYYY-MM-DD]
**Author:** [Author Name]
**Reviewer:** [Reviewer Name]

---

## Source Code Reference

> **Purpose:** This section tracks which version of the source code this test plan was created for.
> When code changes, compare against this reference to identify test updates needed.

| Field | Value |
|-------|-------|
| Repository | `[repository-url]` |
| Branch | `[branch-name]` |
| Commit Hash | `[full-commit-hash]` |
| Commit Date | `[YYYY-MM-DD HH:MM:SS]` |
| Commit Message | `[commit-message-summary]` |

**Source Files Covered:**

```
[List the source code files covered by this test plan]
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

## 1. Introduction

### 1.1 Purpose

[Describe the purpose of this test plan and what it covers]

### 1.2 Scope

**In Scope:**
- [Feature 1]
- [Feature 2]
- [Feature 3]

**Out of Scope:**
- [Excluded item 1]
- [Excluded item 2]

### 1.3 References

| Document | Location |
|----------|----------|
| FSD Specification | `docs/fsd/[module]/INDEX.md` |
| API Specification | `docs/fsd/[module]/[submodule]/spec.md` |
| Requirements | [Link to requirements doc] |

---

## 2. Test Strategy

### 2.1 Test Levels

| Level | Description | Responsibility | Tool/Framework |
|-------|-------------|----------------|----------------|
| Unit | Individual functions/methods | Developer | [JUnit/Jest/etc.] |
| Integration | API endpoints, service interactions | Developer/QA | [Framework] |
| E2E | Full user workflows | QA | [Cypress/Playwright/etc.] |
| Performance | Load and stress testing | QA | [JMeter/k6/etc.] |
| Security | Vulnerability scanning | Security | [OWASP ZAP/etc.] |

### 2.2 Test Types

- [ ] Functional Testing
- [ ] Regression Testing
- [ ] Smoke Testing
- [ ] Integration Testing
- [ ] API Testing
- [ ] UI Testing
- [ ] Performance Testing
- [ ] Security Testing
- [ ] Usability Testing
- [ ] Compatibility Testing

### 2.3 Test Approach

[Describe the overall testing approach - manual vs automated, testing methodology, etc.]

---

## 3. Test Environment

### 3.1 Environment Configuration

| Environment | URL | Purpose |
|-------------|-----|---------|
| Development | `http://localhost:8080` | Local development testing |
| Staging | `https://staging-api.example.com` | Integration testing |
| UAT | `https://uat.example.com` | User acceptance testing |
| Production | `https://api.example.com` | Smoke tests only |

### 3.2 Test Data Requirements

| Data Type | Description | Source |
|-----------|-------------|--------|
| [Data 1] | [Description] | [Seeded/Generated/Production copy] |
| [Data 2] | [Description] | [Source] |

### 3.3 Tools and Infrastructure

| Tool | Version | Purpose |
|------|---------|---------|
| [Tool 1] | [Version] | [Purpose] |
| [Tool 2] | [Version] | [Purpose] |

---

## 4. Features to be Tested

### 4.1 Feature List

| ID | Feature | Priority | Test Type | Status |
|----|---------|----------|-----------|--------|
| F-001 | [Feature Name] | P0 | Unit, Integration, E2E | Not Started |
| F-002 | [Feature Name] | P1 | Unit, Integration | Not Started |
| F-003 | [Feature Name] | P2 | Unit | Not Started |

### 4.2 Feature Details

#### F-001: [Feature Name]

**Description:** [Brief description]

**Business Rules:**
- BR-001: [Business rule 1]
- BR-002: [Business rule 2]

**Test Scenarios:**
1. [Scenario 1]
2. [Scenario 2]
3. [Scenario 3]

**Acceptance Criteria:**
- [ ] [Criteria 1]
- [ ] [Criteria 2]

---

## 5. Test Cases Summary

### 5.1 Test Case Distribution

| Category | Total | P0 | P1 | P2 | P3 |
|----------|-------|----|----|----|----|
| Unit Tests | [N] | [N] | [N] | [N] | [N] |
| Integration Tests | [N] | [N] | [N] | [N] | [N] |
| E2E Tests | [N] | [N] | [N] | [N] | [N] |
| **Total** | **[N]** | **[N]** | **[N]** | **[N]** | **[N]** |

### 5.2 Test Case Mapping

| Test ID | Feature ID | Description | Priority | Automated |
|---------|------------|-------------|----------|-----------|
| TC-001 | F-001 | [Test description] | P0 | Yes |
| TC-002 | F-001 | [Test description] | P1 | Yes |
| TC-003 | F-002 | [Test description] | P2 | No |

---

## 6. Entry and Exit Criteria

### 6.1 Entry Criteria

- [ ] Code complete and deployed to test environment
- [ ] FSD specification approved
- [ ] Test environment available and configured
- [ ] Test data prepared
- [ ] All P0 defects from previous cycle resolved

### 6.2 Exit Criteria

- [ ] All P0 and P1 test cases executed
- [ ] P0 test pass rate: 100%
- [ ] P1 test pass rate: ≥ 95%
- [ ] No open P0 or P1 defects
- [ ] Test summary report completed

### 6.3 Suspension Criteria

- Critical environment issues
- Blocker defects preventing test execution
- Major requirement changes

---

## 7. Risk Assessment

### 7.1 Identified Risks

| ID | Risk | Probability | Impact | Mitigation |
|----|------|-------------|--------|------------|
| R-001 | [Risk description] | High/Medium/Low | High/Medium/Low | [Mitigation strategy] |
| R-002 | [Risk description] | Medium | High | [Mitigation strategy] |

### 7.2 Dependencies

| Dependency | Description | Owner |
|------------|-------------|-------|
| [Dep 1] | [Description] | [Team/Person] |
| [Dep 2] | [Description] | [Team/Person] |

---

## 8. Test Schedule

### 8.1 Milestones

| Milestone | Target Date | Status |
|-----------|-------------|--------|
| Test Plan Approval | [Date] | [Status] |
| Test Case Development | [Date] | [Status] |
| Test Execution Start | [Date] | [Status] |
| Test Execution Complete | [Date] | [Status] |
| Test Report Delivery | [Date] | [Status] |

### 8.2 Resource Allocation

| Role | Name | Allocation |
|------|------|------------|
| Test Lead | [Name] | [%] |
| QA Engineer | [Name] | [%] |
| Developer (Unit Tests) | [Name] | [%] |

---

## 9. Deliverables

| Deliverable | Description | Format |
|-------------|-------------|--------|
| Test Plan | This document | Markdown |
| Test Cases | Detailed test cases | Markdown/Test management tool |
| Test Scripts | Automated test scripts | Code in source repo |
| Test Report | Execution summary | Markdown |
| Defect Report | List of defects found | Issue tracker |

---

## 10. Approvals

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Test Lead | | | |
| Development Lead | | | |
| Product Owner | | | |

---

## Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | [Author] | Initial creation |
