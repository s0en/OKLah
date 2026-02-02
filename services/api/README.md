# OKLah API (Go)

This folder is intentionally a minimal placeholder. Start implementing after you generate tasks via Speckit.

Suggested structure:

```
services/api/
  cmd/api/main.go
  internal/
    http/
    domain/
    storage/
    jobs/
  migrations/
```

Key endpoints for Phase 1:
- POST /v1/auth/anonymous
- POST /v1/checkins
- GET  /v1/status
- GET  /v1/rewards/today



> Note: For Option B (backendless-ish), this API service is optional and can be deferred to Phase 4.
