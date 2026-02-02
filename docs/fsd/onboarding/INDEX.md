# Module: Onboarding

**Status:** 🔄 In Progress
**Derived From:** OKL-PRD-001, OKL-BRD-001 (C1, C2, C3), OKL-BRF-001 §6
**Last Updated:** 2025-02-02

## Overview

The Onboarding module covers the user's journey from first app launch to completing their first check-in. It establishes a privacy-first, anonymous identity and delivers the "first value" moment — recording "I'm OK."

## Submodules

| # | Submodule | Status | Spec | Description |
|---|-----------|--------|------|-------------|
| 1 | Anonymous Onboarding | 📝 In Review | [spec.md](anonymous_onboarding/spec.md) | Privacy screen → anonymous account creation → Home screen |
| 2 | First Check-in | 📝 In Review | [spec.md](first_checkin/spec.md) | "I'm OK" tap → check-in recording → confirmation → streak Day 1 |

## Key PRD Requirements Covered

| PRD Ref | Requirement | Submodule |
|---------|-------------|-----------|
| FR-001 | Anonymous account creation on first launch | Anonymous Onboarding |
| FR-002 | Record check-in on "I'm OK" tap | First Check-in |
| FR-003 | Persist last check-in timestamp locally and backend | First Check-in |
| FR-004 | Display last check-in time on Home screen | First Check-in |
| FR-005 | Initialize streak to 1 on first check-in | First Check-in |

## Dependencies

- Auth provider (e.g., Firebase Anonymous Auth) for anonymous identity
- Local device storage for persistence
- Backend data store for sync
