# OKLah

OKLah is a privacy-first daily check-in mobile application designed to help people living alone build a simple, non-intrusive habit of confirming “I’m OK”.

The product focuses on:
- Anonymous onboarding by default
- One-tap daily check-ins
- Progressive nudges when check-ins are missed
- Lightweight habit reinforcement (streaks, achievements)
- Clear boundaries around privacy and data usage

This repository contains **both product documentation and implementation artifacts**, structured to support a disciplined Product → Spec → Build workflow using Speckit.

---

## Product Scope (Current Phase)

**Phase:** MVP / Beta  
**Target Platforms:** Mobile (Flutter)  
**Distribution:** TestFlight / Google Play Internal Testing  

### In Scope (MVP)
- Anonymous onboarding
- Daily “I’m OK” check-in
- Missed check-in detection
- Push + in-app nudges
- Recovery confirmation flow
- Streaks and basic achievements
- Analytics for activation, retention, and recovery

### Out of Scope (MVP)
- Emergency contact escalation
- Mandatory personal identity data
- Partner or healthcare integrations
- Advanced gamification or social features

---

## Repository Structure (How to Navigate)

This repo follows a **layered, role-driven structure**:

```txt
docs/
  brf/   → Business Requirement Framework (WHY)
  brd/   → Business Requirements (WHAT – business view)
  prd/   → Product Requirements (WHAT – deliverable slices)
  fsd/   → Functional Specs (HOW – implementation-ready)
  nonfunctional/ → Privacy, security, reliability
  decisions/ → Architecture Decision Records (ADR)
  runbooks/ → Operational & release guides

apps/
  mobile/ → Mobile application (Flutter)

services/
  firebase/ → Backend services (Firebase-first)

infra/
  docker/ | k8s/ → Infrastructure (optional for MVP)

plans/
  *.plan → Speckit-generated plans and task breakdowns
