# Implementation Checklist: [FEATURE_NAME]

**Tasks Reference**: specs/[spec-name]/tasks.md
**Created**: [DATE]

---

## Pre-Implementation

- [ ] Spec reviewed and approved
- [ ] Plan reviewed and approved
- [ ] Constitution compliance verified
- [ ] FSD context understood
- [ ] Dependencies identified

---

## Implementation

### Code Quality
- [ ] TypeScript strict mode enabled
- [ ] No ESLint/TSLint errors
- [ ] No compiler warnings
- [ ] Consistent naming conventions
- [ ] No hardcoded values (use constants/config)

### Testing
- [ ] Unit tests written
- [ ] Unit test coverage >= 80%
- [ ] Integration tests written
- [ ] All tests passing
- [ ] Edge cases covered

### Documentation
- [ ] Inline comments for complex logic
- [ ] API documentation (Swagger/OpenAPI)
- [ ] README updated if needed

### Security
- [ ] Input validation implemented
- [ ] Authentication/authorization checked
- [ ] No sensitive data in logs
- [ ] SQL injection prevention verified
- [ ] XSS prevention verified

---

## Post-Implementation

### FSD Update (REQUIRED)
- [ ] `module_XX_name/INDEX.md` updated
- [ ] `module_XX_name/XX_submodule/spec.md` updated
- [ ] Version numbers incremented
- [ ] Change log entries added

### Review
- [ ] Self-review completed
- [ ] Code review requested
- [ ] Review comments addressed

### Deployment
- [ ] PR created
- [ ] CI/CD pipeline passing
- [ ] Merged to main branch

---

## Sign-Off

| Role | Name | Date | Approved |
|------|------|------|----------|
| Developer | | | [ ] |
| Reviewer | | | [ ] |
| Tech Lead | | | [ ] |

---

## Notes

[Any issues encountered or special considerations]
