# FSD Documentation Instructions

This document provides guidelines for generating and maintaining Function Specification Design (FSD) documentation.

---

## 1. Documentation Structure

```
docs/fsd/
├── INSTRUCTIONS.md          # This file - how to use this system
├── SPEC_TEMPLATE.md         # Template for detailed specs
├── FSD_TASK_LIST.md         # Master tracking of all modules
│
├── module_XX_name/          # Module folder
│   ├── INDEX.md             # Module overview & submodule tracking
│   ├── reconciliation/      # Reconciliation with old FSD (if any)
│   │   ├── discrepancies.md     # Technical version
│   │   └── discrepancies-th.md  # Thai Q&A version
│   ├── 01_submodule/        # Submodule folder
│   │   ├── spec.md          # Detailed specification
│   │   ├── stories.md       # User stories (optional)
│   │   └── api.md           # API documentation (optional)
│   └── 02_submodule/
│       └── ...
│
└── module_XX_name.md        # Legacy single-file FSD (to be migrated)
```

---

## 1.1 Markdown Formatting Rules

**CRITICAL: Tables require a blank line before them to render properly.**

```markdown
<!-- WRONG - table won't render -->
**Key Endpoints:**
| Column | Column |
|--------|--------|

<!-- CORRECT - table renders properly -->
**Key Endpoints:**

| Column | Column |
|--------|--------|
```

This applies to ALL tables after any content (headings, bold text, paragraphs, etc.)

---

## 2. Workflow for Creating FSD

### Step 1: Identify the Module

```bash
# Check FSD_TASK_LIST.md for the next module to document
# Look for modules with status: ⬜ Not Started
```

### Step 2: Create Module Structure

```bash
# Create module folder with submodule directories
mkdir -p docs/fsd/module_XX_name/{reconciliation,01_sub,02_sub,03_sub}
```

### Step 3: Analyze the Source Code

```bash
# Read the source files to understand:
# 1. All endpoints/functions
# 2. Related services
# 3. Data models used
# 4. Business logic patterns
```

### Step 4: Create INDEX.md

- Copy structure from existing INDEX.md or template
- List all submodules identified
- Document endpoints per submodule
- Set initial status to "Not Started"

### Step 5: Create Submodule Specs

For each submodule:

1. Copy `SPEC_TEMPLATE.md`
2. Fill in all sections
3. Focus on:
   - User stories with acceptance criteria
   - Business rules
   - API specifications
   - UI/UX if applicable

### Step 6: Update Tracking

- Update module's INDEX.md
- Update FSD_TASK_LIST.md

---

## 3. Quick Reference Commands

### Finding Endpoints (adjust for your framework)

```bash
# List all endpoints in a controller
grep -n "route\|@Get\|@Post\|@Put\|@Delete" [source-file]
```

### Finding Related Models

```bash
# Find model classes
grep -rn "class\|interface\|type" models/
```

### Finding Entity Definitions

```bash
# Find database entity definitions
grep -rn "entity\|table\|schema" [source-folder]/
```

---

## 4. Spec Content Guidelines

### User Stories Format

```markdown
### US-XXX: [Descriptive Title]
**As a** [specific role]
**I want to** [specific action]
**So that** [business value]

**Acceptance Criteria:**
- [ ] Given [context], when [action], then [result]
```

### Business Rules Format

```markdown
### BR-XXX: [Rule Name]
**Description:** [What the rule does]
**Condition:** [When it applies]
**Action:** [What happens]
**Error Message:** [User-facing message]
```

### API Documentation Format

```markdown
### [Endpoint Name]
**Endpoint:** `METHOD /path`
**Description:** [Purpose]
**Request:** [JSON example]
**Response:** [JSON example]
**Errors:** [Error codes and messages]
```

---

## 5. Priority Guidelines

| Priority | Criteria |
|----------|----------|
| HIGH | Core functionality, used daily, critical path |
| MEDIUM | Supporting features, used weekly |
| LOW | Admin features, rarely used |

---

## 6. Status Definitions

| Status | Symbol | Meaning |
|--------|--------|---------|
| Not Started | ⬜ | Work has not begun |
| In Progress | 🔄 | Currently being worked on |
| In Review | 📝 | Awaiting review/approval |
| Completed | ✅ | Done and approved |
| On Hold | ⏸️ | Blocked or paused |

---

## 7. Quality Checklist

Before marking a spec as complete, verify:

- [ ] All user stories have acceptance criteria
- [ ] All business rules are documented
- [ ] All API endpoints have request/response examples
- [ ] Error handling is documented
- [ ] Security/permissions are specified
- [ ] Data model is complete with field descriptions
- [ ] Workflow diagrams are included where applicable
- [ ] Integration points are documented
- [ ] Testing scenarios are defined

---

## 8. Claude Code Prompts

### To Start a New Module

```
Let's create FSD for Module XX: [Name].
1. First analyze the source file [filename]
2. Identify submodules and create the folder structure
3. Create the INDEX.md with tracking
4. Generate the first submodule spec
```

### To Continue a Module

```
Continue FSD for Module XX: [Name].
Check the INDEX.md for the next submodule to document.
Create the spec following the SPEC_TEMPLATE.md format.
```

### To Review Progress

```
Show me the current FSD progress.
Check FSD_TASK_LIST.md and summarize what's done and what's next.
```

### To Generate a Specific Spec

```
Generate spec for Module XX, Submodule YY: [Name].
Focus on:
- User stories for [specific feature]
- Business rules for [specific logic]
- API documentation for [specific endpoints]
```

---

## 9. File Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Module folder | `module_XX_name` | `module_01_user_management` |
| Submodule folder | `XX_name` | `01_registration` |
| Spec file | `spec.md` | `spec.md` |
| Stories file | `stories.md` | `stories.md` |
| API file | `api.md` | `api.md` |
| Index file | `INDEX.md` | `INDEX.md` |

---

## 10. Integration with Development

### For Developers

- Specs serve as requirements for implementation
- User stories → development tasks
- Acceptance criteria → test cases
- Business rules → validation logic

### For QA

- Use acceptance criteria for test planning
- Error handling section for negative testing
- Testing scenarios for test cases

### For BA/PM

- Track progress via INDEX.md and FSD_TASK_LIST.md
- Review specs before development starts
- Use open questions section for clarification

---

## 11. Maintenance

### Regular Updates

- Update specs when requirements change
- Keep tracking files current
- Version significant changes in changelog

### Archiving

- Move outdated specs to `/archive` folder
- Keep at least last 2 versions of specs

---

## 12. Example Session

```markdown
User: Let's work on Module 01 User Management, submodule 01 Registration

Claude: I'll create the spec for Module 01, Submodule 01: Registration.

[Analyzes source files for registration endpoints]
[Creates 01_registration/spec.md using template]
[Fills in user stories, business rules, API specs]
[Updates INDEX.md to mark submodule as In Progress]
[Completes spec and marks as Completed]
```

---

## 13. Reconciliation with Old FSD Documents

When old human-written FSD documents exist (e.g., in `resources/old-fsd/`), follow this reconciliation process:

### Understanding the Two Sources

| Source | Contains | Reliability |
|--------|----------|-------------|
| **Old FSD** | Intended/designed behavior | May be outdated |
| **Code/New FSD** | Actual production behavior | May have deviated from intent |

### Reconciliation Workflow

1. **Don't generate all new FSDs first** - Compare module by module
2. **Create reconciliation folder** in each module: `module_XX/reconciliation/`
3. **Use `DISCREPANCIES_TEMPLATE.md`** to create the discrepancies file
4. **For each discrepancy, determine:**
   - Is code correct? (Update old spec)
   - Is spec correct? (Bug in code)
   - Needs business decision? (Escalate)
5. **Add Business Response placeholders** for items needing decisions

### Discrepancy Types

| Type | Meaning | Action |
|------|---------|--------|
| SPEC_OUTDATED | Code has new features not in spec | Update spec |
| CODE_DIVERGED | Code doesn't match spec | Investigate - bug or intentional? |
| SPEC_MISSING | Spec lacks detail | Add to spec from code |
| CODE_MISSING | Spec has feature not in code | Was it removed? Add to backlog? |
| CONFLICT | Spec and code contradict | Needs business decision |

### Discrepancy Severity

| Severity | Icon | Criteria |
|----------|------|----------|
| High | 🔴 | Affects core functionality, compliance, or critical workflow |
| Medium | 🟡 | Affects user workflow but has workarounds |
| Low | 🟢 | Documentation gap, no functional impact |

### Claude Code Prompts for Reconciliation

```
Reconcile Module XX with old FSD.
Compare `resources/old-fsd/[file].md` with current code.
Use DISCREPANCIES_TEMPLATE.md to create the discrepancies file.
Include business response placeholders for each discrepancy.
```

```
Check business rule BR-X from old FSD against code.
Old FSD says: [quote rule]
Verify in [source file] if this matches.
```

### Reconciliation Files

```
docs/fsd/
├── DISCREPANCIES_TEMPLATE.md      # Template for technical discrepancy files
├── DISCREPANCIES_TH_TEMPLATE.md   # Template for Thai business Q&A version
├── RECONCILIATION_TEMPLATE.md     # General reconciliation template
│
└── module_XX_name/
    ├── reconciliation/
    │   ├── discrepancies.md       # Technical discrepancy log (for developers)
    │   └── discrepancies-th.md    # Thai Q&A version (for business users)
    ├── INDEX.md
    └── 01_submodule/
        └── spec.md
```

---

## 14. Thai Business Q&A Document (discrepancies-th.md)

When reconciling with old FSD, **always generate two files**:

1. **`discrepancies.md`** - Technical version with code evidence (for developers)
2. **`discrepancies-th.md`** - Simplified Thai Q&A version (for business users)

### Purpose

The Thai Q&A document helps business users provide decisions without needing to understand technical details.

### Key Differences

| Aspect | discrepancies.md | discrepancies-th.md |
|--------|------------------|---------------------|
| Language | English | Thai |
| Audience | Developers, Tech leads | Business users, Department heads |
| Content | Code evidence, file references | Simple questions with choices |
| Format | Technical analysis | Q&A with checkboxes |
| Length | Detailed | Concise (lite version) |

---

## 15. Gap Analysis (Code-Generated FSD Review)

When FSD has been generated from source code, run gap analysis to detect issues.

### Purpose

Gap analysis identifies:

- **Documentation Gaps** - Missing or incomplete sections
- **Open Questions** - Unresolved business decisions (254+ found in current FSD)
- **Inconsistencies** - Conflicting information between modules
- **Complex Patterns** - Business logic needing attention
- **Quality Issues** - TODOs, placeholders, formatting problems

### Gap Analysis Files

```
docs/fsd/
├── GAP_ANALYSIS_INSTRUCTIONS.md    # Detailed instructions
├── GAP_ANALYSIS_TEMPLATE.md        # Technical report template
├── GAP_ANALYSIS_TH_TEMPLATE.md     # Thai summary template
│
└── module_XX_name/
    └── reconciliation/
        ├── gap-analysis.md         # Technical analysis output
        └── gap-analysis-th.md      # Thai summary for business
```

### Claude Code Prompts for Gap Analysis

**Full Project Analysis:**

```
Analyze all FSD documentation in /docs/fsd/ for gaps, inconsistencies,
and unusual patterns. Use GAP_ANALYSIS_TEMPLATE.md for output.
```

**Single Module Analysis:**

```
Run gap analysis on Module XX [Name].
Generate gap-analysis.md in the reconciliation folder.
Include Thai summary in gap-analysis-th.md.
```

**Quick Health Check:**

```
Quick FSD health check - list modules with:
1. Open questions
2. TODOs
3. Missing reconciliation files
```

### When to Run

- After completing FSD generation
- After significant code changes
- Before major releases
- During code audits

See `GAP_ANALYSIS_INSTRUCTIONS.md` for complete details.

---

## Questions?

If you have questions about this documentation system:

1. Check the SPEC_TEMPLATE.md for formatting examples
2. Look at completed specs for reference
3. Ask Claude Code for clarification

---

*Last Updated: YYYY-MM-DD*
