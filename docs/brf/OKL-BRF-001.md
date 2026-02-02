# OKL-BRF-001 — OKLah (Privacy-first Daily Check-in) — MVP / Beta

## 1. Executive summary
OKLah is a mobile application for people living alone to do a frictionless, privacy-first daily check-in (ideally one tap) so the system can know they are okay. If a user fails to check in for a configurable number of consecutive days, OKLah performs progressive actions such as nudges (push + in-app) and a guided “I’m OK” confirmation flow. Engagement mechanics (streaks, badges, hall of fame) encourage consistent usage.

The MVP focuses on privacy-first adoption: anonymous onboarding, minimal data collection, configurable thresholds, and basic analytics for understanding activation and retention. Later phases can add premium escalation (emergency contacts and multi-channel outreach), richer profiles, and partner/healthcare add-ons.

## 2. Problem statement
People living alone (or caregivers monitoring them) face a recurring anxiety: “How do I know they are okay today without being intrusive?” Existing solutions either require heavy personal information, feel invasive, or lack a simple daily habit loop that users will actually keep.

## 3. Value proposition
- For end users: a simple daily habit that offers reassurance without sacrificing privacy.
- For families/caregivers (future): progressive escalation when check-ins are missed.
- For the business: a clear MVP that validates retention and willingness to pay for escalation and add-ons.

## 4. Objectives (business + product)
### MVP / Beta objectives
- Validate that privacy-first, anonymous onboarding increases activation.
- Validate daily check-in habit formation (streaks, nudges) and measure retention.
- Prove progressive nudging flow reduces “missed check-in” uncertainty.
- Establish baseline analytics/reporting for product learning (DAU/MAU, check-in completion, nudges, outcomes).

### Phase objectives (beyond MVP)
- Phase 2: subscription premium profile + emergency contacts + escalation workflow + audit trail.
- Phase 3: add-ons via partners/healthcare services with consent flows.
- Phase 4: optional move of core safety logic to a dedicated backend if needed.

## 5. Success metrics (MVP/Beta)
### Activation
- % users completing anonymous onboarding successfully
- Time-to-first-check-in (median)
- Day-1 check-in completion rate

### Retention / habit
- D7 and D30 retention (beta target to be set)
- Avg check-ins per user per week
- Streak distribution (e.g., % users with 3+, 7+, 14+ day streaks)

### Safety loop effectiveness
- Missed check-in events per active user
- Nudge delivery rate (push/in-app) and user response rate
- Confirmation outcomes: “I’m OK” completion rate after a nudge

### Privacy trust
- % users enabling optional features (e.g., proximity / location) after consent
- Drop-off on consent screens (if any)
- Support tickets / feedback tagged “privacy concern”

## 6. In-scope (MVP/Beta)
- Anonymous onboarding (privacy-first; no real name/phone/address required)
- One-tap daily check-in
- Configurable threshold defaults + per-user override
- Progressive nudges:
  - Push notification (FCM)
  - In-app banner and guided “I’m OK” flow
- Engagement:
  - Streaks
  - Basic badges / hall of fame
- Optional “People around you” (privacy-preserving proximity; only if explicitly enabled)
- Basic reporting/analytics (Firebase Analytics + optional BigQuery export)

## 7. Out-of-scope (MVP/Beta)
- Premium escalation to emergency contacts (Phase 2)
- Collecting or requiring sensitive identity fields (name/phone/address) by default
- Storing or sharing raw GPS by default
- Complex partner integrations (Phase 3)
- Dedicated backend service / k8s production setup (Phase 4 only if needed)

## 8. Key assumptions
- Users will adopt a one-tap daily habit if onboarding is anonymous and frictionless.
- Push/in-app nudges can recover missed check-ins without feeling intrusive.
- Gamification improves retention without requiring sensitive profiling.
- Firebase backendless approach maximizes speed for MVP.

## 9. Constraints / non-negotiables
- Privacy-first defaults; no identity required for MVP.
- No raw GPS storage/sharing unless explicitly enabled and clearly explained.
- Clear consent screens for any sensitive data collection.
- Abuse prevention (rate limiting, bot protection/device integrity checks).

## 10. Key stakeholders
### Product / Business
- Product Owner (PO): owns BRF/BRD/PRD scope and success metrics
- Business Analyst (BA): owns specs, acceptance criteria, clarify loops

### Technical
- Solution Architect (SA): owns architecture and NFRs
- Engineering Lead (EL): owns tasks breakdown + delivery plan
- Software Engineers (SE): implement, test, instrument, ship beta

### External / Users
- End users: people living alone
- Future: caregivers/emergency contacts (Phase 2+)

## 11. Dependencies
- Mobile app stack (Flutter)
- Firebase project setup:
  - Auth (Anonymous)
  - Firestore
  - Cloud Functions (scheduled checks / logic)
  - FCM (push nudges)
  - Analytics (+ BigQuery export recommended)

## 12. Risks & mitigations
- Risk: users distrust “safety” apps (privacy fear)
  - Mitigation: anonymous onboarding; explain privacy choices; strong guardrails docs
- Risk: nudges become annoying → churn
  - Mitigation: configurable thresholds; nudge frequency caps; user controls
- Risk: false sense of security without escalation (MVP limitation)
  - Mitigation: explicit product messaging; scope boundaries; roadmap clarity
