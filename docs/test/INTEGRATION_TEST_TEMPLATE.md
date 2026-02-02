# Integration Test Template

Copy this template to create integration test specifications for API endpoints and service interactions.

**Output Location:** `docs/test/backend/[module_name]/integration_tests.md`

---

# [MODULE_NAME] Integration Tests

**Module:** [Module Name]
**Version:** 1.0
**Status:** Draft | Review | Approved | Implemented
**Last Updated:** [YYYY-MM-DD]
**FSD Reference:** `docs/fsd/[module]/[submodule]/spec.md`

---

## Source Code Reference

> **Purpose:** This section tracks which version of the source code these integration tests cover.
> When code changes, compare against this reference to identify test updates needed.

| Field | Value |
|-------|-------|
| Repository | `[repository-url]` |
| Branch | `[branch-name]` |
| Commit Hash | `[full-commit-hash]` |
| Commit Date | `[YYYY-MM-DD HH:MM:SS]` |
| Commit Message | `[commit-message-summary]` |

**Source Files Covered:**

```
[List the source code files covered by these tests]
- src/path/to/file1.ts
- src/path/to/file2.ts
```

**How to check for updates:**

```bash
# View commits since this reference
git log [commit-hash]..HEAD --oneline -- [relevant-paths]

# View detailed changes since reference
git diff [commit-hash]..HEAD -- [relevant-paths]
```

---

## 1. Overview

### 1.1 Purpose

[Describe what integrations are being tested - API endpoints, service-to-service communication, database interactions, external API integrations, etc.]

### 1.2 Scope

**Endpoints Covered:**

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/v1/[resource]` | GET | [Description] |
| `/api/v1/[resource]` | POST | [Description] |
| `/api/v1/[resource]/{id}` | PUT | [Description] |
| `/api/v1/[resource]/{id}` | DELETE | [Description] |

### 1.3 Dependencies

| Dependency | Type | Mock/Real |
|------------|------|-----------|
| Database | PostgreSQL | Real (test DB) |
| Cache | Redis | Mock |
| External API | [Service] | Mock |
| Message Queue | [Queue] | Mock |

---

## 2. Test Environment Setup

### 2.1 Prerequisites

```bash
# Environment variables required
DATABASE_URL=postgresql://test:test@localhost:5432/sspos_test
REDIS_URL=redis://localhost:6379
API_BASE_URL=http://localhost:8080/api/v1
```

### 2.2 Test Data Setup

```sql
-- SQL script for test data seeding
-- Location: /test/fixtures/[module]_test_data.sql

INSERT INTO [table] (id, name, ...) VALUES
(1, 'Test Record 1', ...),
(2, 'Test Record 2', ...);
```

### 2.3 Authentication Setup

```json
// Test user credentials
{
  "username": "test_user",
  "password": "test_password",
  "role": "ADMIN",
  "companyId": 1,
  "storeId": 1
}
```

---

## 3. API Endpoint Tests

### 3.1 [ENDPOINT_NAME] - `[METHOD] /api/v1/[path]`

**FSD Reference:** Section [X.X] of spec.md

#### 3.1.1 Test Cases

| ID | Test Case | Priority | Status |
|----|-----------|----------|--------|
| IT-001 | [Happy path description] | P0 | Not Started |
| IT-002 | [Validation error case] | P1 | Not Started |
| IT-003 | [Authorization test] | P0 | Not Started |
| IT-004 | [Edge case] | P2 | Not Started |

---

#### IT-001: [Happy Path Test Name]

**Description:** [What this test verifies]

**Preconditions:**
- User is authenticated with role [ROLE]
- [Required data exists in database]

**Request:**

```http
[METHOD] /api/v1/[path]
Authorization: Bearer {token}
Content-Type: application/json

{
  "field1": "value1",
  "field2": "value2"
}
```

**Expected Response:**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "success": true,
  "data": {
    "id": 1,
    "field1": "value1",
    "field2": "value2",
    "createdAt": "2025-01-01T00:00:00Z"
  }
}
```

**Assertions:**
- [ ] Response status code is 200
- [ ] Response body contains `success: true`
- [ ] Response data matches expected schema
- [ ] Database record is created/updated
- [ ] [Additional assertions]

**Database Verification:**

```sql
-- Verify database state after API call
SELECT * FROM [table] WHERE id = [expected_id];
-- Expected: [description of expected data]
```

---

#### IT-002: [Validation Error Test Name]

**Description:** [What validation is being tested]

**Preconditions:**
- User is authenticated

**Request:**

```http
POST /api/v1/[path]
Authorization: Bearer {token}
Content-Type: application/json

{
  "field1": "",  // Invalid: empty required field
  "field2": "invalid_value"
}
```

**Expected Response:**

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json

{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "field1",
        "message": "Field1 is required"
      }
    ]
  }
}
```

**Assertions:**
- [ ] Response status code is 400
- [ ] Error code is `VALIDATION_ERROR`
- [ ] Error details contain field-specific messages
- [ ] No database changes occurred

---

#### IT-003: [Authorization Test Name]

**Description:** Verify unauthorized access is rejected

**Test Matrix:**

| Role | Expected Result |
|------|-----------------|
| SUPERADMIN | 200 OK |
| ADMIN | 200 OK |
| USER | 403 Forbidden |
| No Auth | 401 Unauthorized |

**Request (Unauthorized):**

```http
[METHOD] /api/v1/[path]
Authorization: Bearer {user_token}  // USER role
```

**Expected Response:**

```http
HTTP/1.1 403 Forbidden
Content-Type: application/json

{
  "success": false,
  "error": {
    "code": "FORBIDDEN",
    "message": "You do not have permission to perform this action"
  }
}
```

---

#### IT-004: [Edge Case Test Name]

**Description:** [Edge case being tested - boundary values, empty data, etc.]

**Request:**

```http
[METHOD] /api/v1/[path]
Authorization: Bearer {token}
Content-Type: application/json

{
  "field1": "[boundary_value]"
}
```

**Expected Response:**

```http
HTTP/1.1 [status_code]
Content-Type: application/json

{
  // Expected response body
}
```

**Assertions:**
- [ ] [Edge case specific assertions]

---

## 4. Service Integration Tests

### 4.1 [Service Name] Integration

**Description:** Test integration between [Service A] and [Service B]

#### Test Cases

| ID | Test Case | Priority |
|----|-----------|----------|
| SIT-001 | [Service interaction description] | P1 |
| SIT-002 | [Error handling between services] | P1 |

---

#### SIT-001: [Service Integration Test Name]

**Description:** [What service interaction is being tested]

**Flow:**

```mermaid
sequenceDiagram
    participant C as Client
    participant A as Service A
    participant B as Service B
    participant DB as Database

    C->>A: Request
    A->>B: Internal call
    B->>DB: Query
    DB-->>B: Result
    B-->>A: Response
    A-->>C: Final response
```

**Setup:**
- [Service A mock/real configuration]
- [Service B mock/real configuration]

**Input:**

```json
{
  "request": "data"
}
```

**Expected Outcome:**
- [ ] Service A calls Service B with correct parameters
- [ ] Service B returns expected data
- [ ] Final response is correctly aggregated

---

## 5. Database Integration Tests

### 5.1 Transaction Tests

| ID | Test Case | Description |
|----|-----------|-------------|
| DIT-001 | Transaction rollback | Verify rollback on error |
| DIT-002 | Concurrent access | Verify optimistic locking |

---

#### DIT-001: Transaction Rollback Test

**Description:** Verify that database changes are rolled back when an error occurs mid-transaction

**Setup:**

```sql
-- Initial state
SELECT COUNT(*) FROM [table]; -- Expected: N
```

**Action:**
1. Start transaction
2. Insert record A
3. Trigger error condition
4. Verify rollback

**Expected:**

```sql
-- After rollback
SELECT COUNT(*) FROM [table]; -- Expected: N (unchanged)
```

---

## 6. External API Integration Tests

### 6.1 [External Service] Integration

**Service:** [External service name]
**Mock Strategy:** [WireMock/MockServer/etc.]

#### Test Cases

| ID | Test Case | Mock Response |
|----|-----------|---------------|
| EIT-001 | Successful response | 200 OK with data |
| EIT-002 | Service unavailable | 503 Service Unavailable |
| EIT-003 | Timeout handling | Connection timeout |

---

#### EIT-001: [External API Success Test]

**Mock Setup:**

```json
// WireMock stub
{
  "request": {
    "method": "POST",
    "url": "/external/api/endpoint"
  },
  "response": {
    "status": 200,
    "body": "{\"result\": \"success\"}",
    "headers": {
      "Content-Type": "application/json"
    }
  }
}
```

**Expected Behavior:**
- [ ] External API is called with correct payload
- [ ] Response is correctly parsed
- [ ] Data is stored/processed correctly

---

## 7. Error Handling Tests

### 7.1 Error Scenarios

| ID | Scenario | Expected Behavior |
|----|----------|-------------------|
| ERR-001 | Database connection lost | Graceful error response, retry logic |
| ERR-002 | External API timeout | Fallback response, circuit breaker |
| ERR-003 | Invalid request data | Validation error with details |

---

## 8. Performance Baseline Tests

### 8.1 Response Time Requirements

| Endpoint | Expected P50 | Expected P95 | Expected P99 |
|----------|--------------|--------------|--------------|
| GET /api/v1/[resource] | < 100ms | < 300ms | < 500ms |
| POST /api/v1/[resource] | < 200ms | < 500ms | < 1000ms |

### 8.2 Throughput Requirements

| Endpoint | Expected RPS |
|----------|--------------|
| GET /api/v1/[resource] | 100 |
| POST /api/v1/[resource] | 50 |

---

## 9. Test Implementation Reference

### 9.1 Kotlin (Spring Boot)

```kotlin
@SpringBootTest
@AutoConfigureMockMvc
class [Feature]IntegrationTest {

    @Autowired
    private lateinit var mockMvc: MockMvc

    @Test
    fun `IT-001 - should [test description]`() {
        // Given
        val request = """
            {
                "field1": "value1"
            }
        """.trimIndent()

        // When
        val result = mockMvc.perform(
            post("/api/v1/[path]")
                .contentType(MediaType.APPLICATION_JSON)
                .content(request)
                .header("Authorization", "Bearer $token")
        )

        // Then
        result
            .andExpect(status().isOk)
            .andExpect(jsonPath("$.success").value(true))
            .andExpect(jsonPath("$.data.field1").value("value1"))
    }
}
```

### 9.2 JavaScript (Jest + Supertest)

```javascript
describe('[Feature] Integration Tests', () => {
  let token;

  beforeAll(async () => {
    token = await getTestToken();
  });

  test('IT-001 - should [test description]', async () => {
    // Given
    const request = {
      field1: 'value1'
    };

    // When
    const response = await supertest(app)
      .post('/api/v1/[path]')
      .set('Authorization', `Bearer ${token}`)
      .send(request);

    // Then
    expect(response.status).toBe(200);
    expect(response.body.success).toBe(true);
    expect(response.body.data.field1).toBe('value1');
  });
});
```

---

## 10. Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | [Author] | Initial creation |
