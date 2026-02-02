# /init-fsd

Initialize the FSD documentation system for this project.

## What This Command Does

1. **Gather Project Information**
   - Project name
   - Repository URL
   - Tech stack
   - Initial module list

2. **Configure Files**
   - Update `CLAUDE.md` with project details
   - Update `.specify/memory/constitution.md` with project name and date
   - Update `docs/FSD_TASK_LIST.md` with modules
   - Update `docs/fsd/MODULE_DEPENDENCY_MAP.md`

3. **Set Up Structure**
   - Create module folders in `docs/fsd/`
   - Configure git submodules (if applicable)

4. **Verify Setup**
   - Check no placeholders remain
   - Validate folder structure

## Usage

Simply type:
```
init the fsd
```

Or use the slash command:
```
/init-fsd
```

## Post-Initialization

After initialization, you can:
- Create FSD: `Generate FSD for Module 01: [Name]`
- Create specs: `/speckit.specify [feature]`
- Check progress: `Show FSD_TASK_LIST.md`

## See Also

- [INIT_INSTRUCTIONS.md](../../INIT_INSTRUCTIONS.md) - Detailed initialization workflow
- [CLAUDE.md](../../CLAUDE.md) - Main instructions file
