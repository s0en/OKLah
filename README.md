# FSD Skeleton Template

A complete project skeleton for Function Specification Design (FSD) documentation with Speckit integration. Copy this template to any new project to get a fully configured documentation system.

## Quick Start

1. **Copy to your project:**

   ```bash
   cp -r fsd-skeleton-template/* /path/to/your/project/
   ```

2. **Tell Claude to initialize:**

   ```
   init the fsd
   ```

   Claude will:
   - Update placeholders in CLAUDE.md with your project details
   - Configure the FSD task list for your modules
   - Set up the constitution with your project name
   - Initialize git submodules (if applicable)

## What's Included

```
fsd-skeleton-template/
├── CLAUDE.md                    # Instructions for Claude Code
├── INIT_INSTRUCTIONS.md         # What Claude does on "init the fsd"
│
├── .claude/
│   └── commands/
│       └── init-fsd.md          # Slash command for initialization
│
├── .specify/                    # Speckit templates
│   ├── memory/
│   │   └── constitution.md      # Project constitution with FSD sync rules
│   └── templates/
│       ├── spec-template.md     # Feature specification template
│       ├── plan-template.md     # Implementation plan template
│       ├── tasks-template.md    # Task list template
│       └── checklist-template.md
│
├── docs/
│   ├── FSD_TASK_LIST.md         # Master tracking file
│   ├── fsd/
│   │   ├── INSTRUCTIONS.md      # How to use FSD system
│   │   ├── SPEC_TEMPLATE.md     # Detailed spec template
│   │   ├── DISCREPANCIES_TEMPLATE.md
│   │   ├── DISCREPANCIES_TH_TEMPLATE.md
│   │   ├── RECONCILIATION_TEMPLATE.md
│   │   ├── GAP_ANALYSIS_INSTRUCTIONS.md
│   │   ├── GAP_ANALYSIS_TEMPLATE.md
│   │   ├── GAP_ANALYSIS_TH_TEMPLATE.md
│   │   ├── MODULE_DEPENDENCY_MAP.md
│   │   └── module_XX_example/   # Example module structure
│   │       ├── INDEX.md
│   │       └── reconciliation/
│   └── test/
│       ├── TESTING_INSTRUCTIONS.md
│       └── [test templates]
│
└── resources/
    └── old-fsd/                 # Place old FSD docs here for reconciliation
```

## Key Features

### 1. FSD Documentation System
- Structured module documentation
- Cross-reference support between modules
- Gap analysis tools
- Reconciliation with legacy documentation
- Thai language support for business stakeholders

### 2. Speckit Integration
- Feature specification templates
- Implementation planning
- Task generation
- **Constitution with FSD Sync Rules** (bidirectional documentation sync)

### 3. Constitution Principles
The included constitution enforces:
- **FSD-Speckit Bidirectional Sync**: Specs must reference FSD, implementations must update FSD
- **Documentation Traceability**: Clear links between spec → implementation → FSD
- **Single Source of Truth**: FSD is authoritative for existing business logic

## Initialization Details

When you run "init the fsd", Claude will:

1. **Project Configuration**
   - Ask for project name
   - Ask for repository URL
   - Ask for source code structure (monorepo/multi-repo)

2. **Git Submodules** (if applicable)
   - Set up submodules for source code repositories
   - Configure paths in CLAUDE.md

3. **FSD Setup**
   - Create initial module list based on codebase analysis
   - Update FSD_TASK_LIST.md with modules
   - Configure priority levels

4. **Speckit Configuration**
   - Update constitution with project name
   - Configure templates for your tech stack

## Usage After Initialization

### Creating FSD for a Module

```
Create FSD for Module XX: [Name]
Analyze the source code and generate documentation.
```

### Creating a New Feature Spec

```
/speckit.specify [feature description]
```

### Generating Implementation Tasks

```
/speckit.tasks
```

### Running Gap Analysis

```
/speckit.analyze
```

## Customization

### Adding Project-Specific Rules

Edit `CLAUDE.md` to add:
- Build/run command restrictions
- Naming conventions
- Architecture patterns
- Code organization rules

### Modifying the Constitution

Edit `.specify/memory/constitution.md` to:
- Add new principles
- Modify compliance requirements
- Update governance rules

## File Descriptions

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Main instructions Claude follows |
| `INIT_INSTRUCTIONS.md` | Detailed init workflow |
| `.claude/commands/init-fsd.md` | Slash command definition |
| `.specify/memory/constitution.md` | Project governance rules |
| `docs/FSD_TASK_LIST.md` | Progress tracking |
| `docs/fsd/INSTRUCTIONS.md` | FSD creation guide |

## License

This template is provided as-is for use in your projects.
