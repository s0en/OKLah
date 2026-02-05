OKL-PRD-003 — Streaks, Achievements & Feedback

Status: Draft
Owner: Product Owner (PO)
Derived from: OKL-BRD-001
Related Business Rules: BR-OKL-003, BR-OKL-004, BR-OKL-005, BR-OKL-006
Related Capabilities: CAP-OKL-003, CAP-OKL-004
Date: YYYY-MM-DD

## 1. Problem Statement

Sustained engagement benefits from simple, understandable reinforcement.
Without clear rules, streaks and rewards can confuse users or undermine trust.

## 2. User Intent

As a regular user,
I want to see my consistency acknowledged,
so that I feel motivated to continue my daily practice.

## 3. Goals

- G-01 Track consecutive daily check-ins.
- G-02 Reset streaks transparently after missed days.
- G-03 Reinforce engagement with positive feedback.

## 4. Non-Goals

- NG-01 Competitive leaderboards.
- NG-02 Monetary or tangible rewards.
- NG-03 Social comparison.

## 5. In Scope

- Streak calculation and reset logic.
- Achievement evaluation.
- User-facing feedback messaging.

## 6. Out of Scope

- Advanced gamification systems.
- Personal coaching or advice.
- Social features.

## 7. Success Metrics

- Average streak length.
- % users maintaining 7-day streaks.
- User satisfaction with feedback clarity.

## 8. Constraints (Inherited)

- One check-in per calendar day (BR-OKL-003).
- Base timezone anchoring (BR-OKL-004).
- Streak resets after missed days (BR-OKL-005).
- Non-punitive reinforcement (BR-OKL-006).

## 9. Risks & Trade-offs

- R-01 Over-gamification may trivialize intent.
- R-02 Under-feedback may reduce motivation.
Trade-off: Favor clarity and emotional safety over complexity.

## 10. Open Decisions
None.

## 11. FSD Decomposition (authoritative)

This PRD SHALL be decomposed into the following FSD submodules:

- gamification/streak_tracking
Rationale: Core continuity logic with strict correctness requirements.

- gamification/achievement_evaluation
Rationale: Derived outcomes based on streak state that may expand over time.

- feedback/user_feedback_signals
Rationale: Messaging and reinforcement behavior should evolve independently of state logic.

Decomposition rationale summary
Separating durable state from derived rewards and messaging enables safe iteration and clearer ownership.

## 12. Acceptance Boundary

- BA derives FSD specs only.
- No UI flows, state machines, or technical implementations defined here.