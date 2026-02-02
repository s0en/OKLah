# OKLah – Canonical Product & System Identity

Product Name (Display):
- OKLah

Product Code:
- OKL

App IDs:
- Android: com.oklah.app
- iOS (bundle id): com.oklah.app

Firebase Project ID:
- oklah-mvp

Backend / Service Prefix:
- oklah

Repository Slug:
- oklah-speckit

# Project Config — OKLah

## Product phases
- **Phase 1 (MVP):** Frictionless adoption + strong privacy
  - Anonymous onboarding (no real name, phone, address)
  - Daily check-in button
  - System threshold defaults + per-user override
  - Nudges via push/in-app + guided “I’m OK” flow
  - Streaks + basic badges
  - Optional proximity “People around you” (privacy-preserving)
- **Phase 2 (Subscription):** Safety contacts + richer profile (opt-in)
  - User may provide name/phone/address/emergency contacts
  - Escalation workflow and audit trail
  - Strong privacy guardrails + access controls
- **Phase 3 (Add-ons):** Healthcare/assistance ecosystem integrations
  - Connectors, referral links, partner APIs, and consent flows
- **Phase 4 (Optional):** Dedicated backend service if needed

## Non-negotiables
- Privacy-first defaults (no identity required in Phase 1)
- No raw GPS storage or sharing unless explicitly enabled + explained
- Clear consent screens for any sensitive data (health, address, emergency contacts)
- Abuse prevention (rate limiting, bot protection, device integrity checks)

## Tech stack (Option B)
### Mobile
- Flutter (stable channel)
- forui for UI components
- Local storage: secure storage for device secrets + minimal cached state

### Backendless foundation
- Firebase Auth: Anonymous sign-in
- Cloud Firestore: data store (append-only logs for key safety events)
- Cloud Functions: business rules + scheduled checks
- FCM: push notifications
- Firebase Analytics -> BigQuery export: reporting

### Reporting
- BigQuery datasets for:
  - DAU/MAU, check-in completion rate
  - streak distribution / churn signals
  - thresholds breached, nudges sent, user confirmation outcomes
  - premium escalation attempts + outcomes (for audit)

### DevOps
- Local dev: Firebase Emulator Suite
- Deploy: Firebase CLI + GitHub Actions (optional later)
- K8s: not required for MVP; only if you later move to a dedicated service.

