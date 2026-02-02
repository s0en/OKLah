# OKL-PRD-003 — OKLah — Streaks + Basic Achievements + Beta Feedback
Status: Draft
Derived From: OKL-BRD-001 (BR-OKL-006, BR-OKL-008)
Goal: Improve retention and capture beta learning quickly

## 1. Problem / opportunity
Even a good check-in tool fails if users don’t form the habit. Lightweight streaks + a feedback channel help retention and iteration.

## 2. Scope (in)
- Streak count visible on home screen
- Streak rules for increment/reset (simple version)
- 2–3 basic achievements (e.g., 3-day, 7-day, 14-day streak)
- “Hall of fame” or simple achievements list
- Beta feedback channel (in-app form or mailto link)

## 3. Out of scope
- Complex gamification economy
- Social sharing
- Leaderboards requiring public identity

## 4. Functional requirements (FR)
FR-201: The system shall display current streak count on home.
FR-202: The system shall increment streak when check-in occurs within same day window rules.
FR-203: The system shall reset or pause streak based on missed check-in rule (define: reset on missed).
FR-204: The system shall unlock achievements at defined milestones and display them.
FR-205: The system shall allow users to submit beta feedback (category + message).

## 5. Acceptance criteria
AC-201: After consecutive daily check-ins, streak increments correctly.
AC-202: After a missed check-in beyond threshold, streak resets (MVP rule).
AC-203: Achievements unlock at the correct milestones and persist.
AC-204: Feedback submissions are captured (and visible in logs/store).

## 6. Analytics (minimum events)
- event: streak_incremented
- event: streak_reset
- event: achievement_unlocked
- event: feedback_submitted
Properties: streak_count, achievement_id, feedback_category
