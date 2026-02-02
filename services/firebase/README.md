# Firebase service (backendless)

This folder contains:
- Firestore security rules
- Cloud Functions (TypeScript)
- Emulator configuration

## Functions included (skeleton)
- `recordCheckIn` — writes check-in event + updates streak
- `evaluateThresholds` (scheduled) — finds users who breached threshold and creates nudge actions
- `sendNudge` — sends push (FCM) and records outcome
- `startPremiumEscalation` — premium-only workflow (placeholder)

These are intentionally minimal for Speckit planning. Implement via Speckit tasks.

