# [PROJECT_NAME] Constitution

**Version**: 1.0.0 | **Ratified**: [DATE] | **Last Amended**: [DATE]

---

## Preamble

This Constitution establishes the foundational principles, standards, and governance rules for the [PROJECT_NAME] project. All AI assistants and team members must adhere to these principles.

---

## Article I: Core Principles

### Principle I: TypeScript Strict Mode (NON-NEGOTIABLE)

**Requirement:** All TypeScript code must use strict mode.

- Every value must be explicitly typed
- No implicit `any` allowed
- Enable all strict compiler options

### Principle II: FSD-Speckit Bidirectional Sync (NON-NEGOTIABLE)

**Requirement:** Code and FSD documentation must always be synchronized.

1. **Before Implementation:**
   - Review existing FSD documentation
   - Reference relevant modules in specifications
   - Identify required FSD updates

2. **After Implementation:**
   - Update module INDEX.md
   - Update/create submodule spec.md
   - Increment version numbers
   - Implementation is INCOMPLETE until FSD is updated

### Principle III: Documentation Traceability (NON-NEGOTIABLE)

**Requirement:** All specifications must maintain clear traceability.

- Specs reference FSD modules
- Plans reference specs
- Tasks reference plans
- Implementations reference tasks

---

## Article II: Coding Standards

### Section 1: Naming Conventions

- **Files**: kebab-case (`user-service.ts`)
- **Classes**: PascalCase (`UserService`)
- **Functions**: camelCase (`getUserById`)
- **Constants**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`)

### Section 2: Error Handling

- Always use typed error classes
- Never swallow exceptions silently
- Log errors with context
- Return meaningful error messages

### Section 3: Testing Requirements

- Unit tests for all business logic
- Integration tests for API endpoints
- Minimum 80% code coverage target

---

## Article III: Architecture Principles

### Section 1: Separation of Concerns

- Controllers handle HTTP layer only
- Services contain business logic
- Repositories handle data access
- Models define data structures

### Section 2: Dependency Injection

- Use constructor injection
- Define interfaces for dependencies
- Enable testability through DI

## Article IV: AI Constituion Addendum (PCISSC, RMiT Safe)

### Section 1: GOVERN (Accountability, approvals, evidence)
1. Non-negotiable
   - AI is advisory. Humans are accountable for correctness, security, and compliance.
   - Every Story/CR must retain an Evidence Pack link (in Jira):
     + SpecKit spec location (specs/.../spec.md)
     + FSD references updated (module INDEX/spec paths)
     + PR links
     + Test evidence link(s)
     + “AI usage declaration” (Yes/No + what artifacts: spec/tasks/code/tests)

2. Review gates
   - Architect/TL must review any work tagged: PCI-IN-SCOPE, SECRET-RISK, CRYPTO-RISK
   - PR cannot merge unless “FSD Sync Checklist” is complete (your framework already treats this as blocking)

### Section 2: MAP (Data boundaries + what can go into Claude/Cusror/LLMs)
1. Prohibited (never paste into Claude/Cursor/LLMS)
   - Any credentials (including “encrypted” passwords), keys, tokens, secrets
   - Any real customer PII or production logs with identifiers
   - Screenshots (pilot rule: not allowed)

2. Allowed (with redaction)
   - Sanitized code snippets
   - Sanitized configs (placeholders only)
   - Synthetic test data only
   - Architecture descriptions, interface contacts

3. Mandatory redaction checklist (before using AI)
   - Remove secrets/credentials
   - Mask identifiers (customer IDs, phone, email)
   - Remove any production log lines unless scrubbed
   - Confirm file is outside sensitive scope before sharing

### Section 3: MEASURE (Provde controls work)
Track weekly:
- secret-scan pass rate (Github Action)
- secret findings (should trend to zero)
- FSD drift count (weekly gap analysis)
- Rework gate (stories reopened) + defect escape rate

### Section 2: MANAGE (Controls in SDLC + incident handling)
1. Merge gates (required checks)
   - Secret scan passes
   - Build + unit test pass
   - Dependency vulnerability scan passess (or exceptions logged)
   - FSD sync confirmed (INDEX/spec updated where required)

2. If a secret/residue is found
   - Stop work on branch
   - Rotate credential
   - Purge from repo history if it ever entered git
   - Create a Jira incident ticket + record remediation

---

## Article V: Security Requirements

### Section 1: Input Validation

- Validate all external input
- Use DTOs with validation decorators
- Sanitize user input

### Section 2: Authentication & Authorization

- All endpoints require authentication (unless explicitly public)
- Use role-based access control
- Audit sensitive operations

---

## Article V: Amendment Process

1. **Proposal**: Document proposed change with rationale
2. **Review**: Team review and discussion
3. **Approval**: Majority approval required
4. **Update**: Increment version, update Last Amended date

---

## Signatories

- [Tech Lead Name] - Technical Authority
- [Architect Name] - Architecture Authority
- [Date of Ratification]

---

*This Constitution is binding for all development activities on [PROJECT_NAME].*
