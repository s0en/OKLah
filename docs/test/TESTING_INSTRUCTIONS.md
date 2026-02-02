# Testing Documentation Instructions

This guide explains how to create and maintain test documentation for SSPOS using the provided templates.

---

## Overview

Test documentation in this project serves as **specifications and plans**, not executable tests. Actual unit tests, integration tests, and E2E tests should be implemented in their respective source code repositories.

### Documentation Types

| Document Type | Purpose | Template | Output Location |
|---------------|---------|----------|-----------------|
| Test Plan | Overall testing strategy for a module/feature | `TEST_PLAN_TEMPLATE.md` | `docs/test/backend/[module]/test_plan.md` |
| Integration Tests | API and service integration scenarios | `INTEGRATION_TEST_TEMPLATE.md` | `docs/test/backend/[module]/integration_tests.md` |
| E2E Tests | End-to-end user flow specifications | `E2E_TEST_TEMPLATE.md` | `docs/test/[frontend]/e2e_tests.md` |
| QA Checklist | Manual testing checklist for QA team | `QA_CHECKLIST_TEMPLATE.md` | `docs/test/[module]/qa_checklist.md` |

---

## Directory Structure

```
docs/
├── test/                               # Testing templates & instructions
│   ├── TESTING_INSTRUCTIONS.md         # This file
│   ├── TEST_PLAN_TEMPLATE.md           # Test plan template
│   ├── INTEGRATION_TEST_TEMPLATE.md    # Integration test template
│   ├── E2E_TEST_TEMPLATE.md            # E2E test template
│   ├── QA_CHECKLIST_TEMPLATE.md        # QA checklist template
│   │
│   ├── backend/                        # Backend test documentation
│   │   ├── module_01_authentication/
│   │   │   ├── test_plan.md
│   │   │   ├── integration_tests.md
│   │   │   └── qa_checklist.md
│   │   └── module_XX_name/
│   │       └── ...
│   │
│   ├── frontend_backoffice/            # Backoffice test documentation
│   │   ├── test_plan.md
│   │   ├── e2e_tests.md
│   │   └── qa_checklist.md
│   │
│   └── frontend_mobile/                # Mobile test documentation
│       ├── test_plan.md
│       ├── e2e_tests.md
│       └── qa_checklist.md
│
└── fsd/                                # FSD specifications (separate)
    ├── module_XX_name/
    │   ├── INDEX.md
    │   └── XX_submodule/
    │       └── spec.md
    ├── frontend_backoffice/
    └── frontend_mobile/
```

---

## How to Generate Test Documentation

### Step 1: Choose the Module/Feature

Identify which module or feature needs test documentation:
- Backend modules: `module_01_authentication`, `module_02_orders`, etc.
- Frontend pages: `frontend_backoffice/XX_page`
- Mobile ViewModels: `frontend_mobile/XX_viewmodel`

### Step 2: Read the FSD Specification

Before generating test documentation, always read the relevant spec.md files:
- Understand the business logic and rules
- Identify all API endpoints and their behaviors
- Note validation rules and error scenarios
- Review UI workflows and state transitions

### Step 3: Use the Appropriate Template

Copy the relevant template(s) and fill in the placeholders:

```bash
# Example: Create testing folder for orders module
mkdir -p docs/test/backend/module_02_orders

# Copy templates (conceptually)
# Fill placeholders: [MODULE_NAME], [FEATURE_NAME], [ENDPOINT], etc.
```

### Step 4: Generate Test Cases

For each template, follow these guidelines:

#### Test Plan
1. Define scope based on the module's INDEX.md
2. List all features from submodule specs
3. Identify test types needed (unit, integration, E2E)
4. Set priorities based on business criticality
5. Define entry/exit criteria

#### Integration Tests
1. Extract all API endpoints from spec.md
2. Define positive test cases (happy path)
3. Define negative test cases (validation errors, edge cases)
4. Document request/response payloads
5. Specify assertions and expected behaviors

#### E2E Tests
1. Map user stories from spec.md to test scenarios
2. Define preconditions and test data
3. Write step-by-step actions
4. Specify expected outcomes
5. Consider cross-browser/cross-device requirements

#### QA Checklist
1. Convert business rules to checkable items
2. Group by functional area
3. Include edge cases and boundary conditions
4. Add regression test items
5. Include performance and security checks

---

## Prompt Templates for AI Generation

Use these prompts when asking Claude to generate test documentation:

### Generate Test Plan

```
Read the FSD specification at docs/fsd/[MODULE]/INDEX.md and all submodule specs.
Create a comprehensive test plan using the TEST_PLAN_TEMPLATE.md template.

Module: [MODULE_NAME]
Focus areas: [LIST KEY FEATURES]
Priority: [HIGH/MEDIUM/LOW]
```

### Generate Integration Tests

```
Read the FSD specification at docs/fsd/[MODULE]/[SUBMODULE]/spec.md.
Create integration test scenarios using the INTEGRATION_TEST_TEMPLATE.md template.

Feature: [FEATURE_NAME]
API Endpoints: [LIST ENDPOINTS]
Include: positive cases, negative cases, edge cases, security tests
```

### Generate E2E Tests

```
Read the FSD specification at docs/fsd/[FRONTEND]/[PAGE]/spec.md.
Create E2E test scenarios using the E2E_TEST_TEMPLATE.md template.

Page/Feature: [PAGE_NAME]
User roles: [LIST ROLES]
Critical flows: [LIST MAIN USER JOURNEYS]
```

### Generate QA Checklist

```
Read the FSD specification at docs/fsd/[MODULE]/INDEX.md and submodule specs.
Create a QA checklist using the QA_CHECKLIST_TEMPLATE.md template.

Module: [MODULE_NAME]
Testing phase: [DEVELOPMENT/STAGING/PRE-RELEASE]
Include: functional tests, UI tests, security tests, performance tests
```

---

## Best Practices

### 1. Traceability

Always link test cases back to requirements:
```markdown
**Requirement:** FR-001 (from spec.md Section 4.1)
**Test Case:** TC-001
```

### 2. Test Data Management

Document test data requirements clearly:
```markdown
### Test Data
| Data | Value | Purpose |
|------|-------|---------|
| Valid username | `testuser@example.com` | Happy path login |
| Invalid username | `invalid` | Validation error test |
```

### 3. Environment Specification

Always specify the target environment:
```markdown
### Environment
- **Target:** Staging
- **Backend URL:** https://staging-api.example.com
- **Database:** PostgreSQL (seeded with test data)
```

### 4. Priority Classification

Use consistent priority levels:

| Priority | Description | When to Run |
|----------|-------------|-------------|
| P0 - Critical | Core functionality, blocks release | Every build |
| P1 - High | Important features | Daily |
| P2 - Medium | Standard features | Weekly |
| P3 - Low | Edge cases, nice-to-have | Before release |

### 5. Status Tracking

Keep test documentation status updated:
```markdown
| Status | Meaning |
|--------|---------|
| Draft | Initial creation, not reviewed |
| Review | Under review by QA lead |
| Approved | Ready for implementation |
| Implemented | Tests coded in source repo |
```

---

## Mapping to Source Repositories

After creating test documentation, actual tests should be implemented in source repositories:

### Backend (sspos-backend)

```
sspos-backend/
└── src/test/kotlin/com/sspos/
    ├── unit/           # Unit tests
    ├── integration/    # Integration tests (use @SpringBootTest)
    └── e2e/            # E2E API tests
```

### Backoffice (sspos-backoffice)

```
sspos-backoffice/
└── src/
    ├── __tests__/      # Unit tests (Jest)
    ├── components/
    │   └── *.test.js   # Component tests
    └── e2e/            # E2E tests (Cypress/Playwright)
```

### Mobile (sspos-mobile)

```
sspos-mobile/
└── androidApp/src/
    ├── test/           # Unit tests (JUnit)
    └── androidTest/    # Instrumented tests (Espresso)
```

---

## Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-12-04 | Claude Code | Initial creation |
