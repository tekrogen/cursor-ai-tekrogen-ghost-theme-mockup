# FEAT-001: Migrate Agent Loader to Claude Skills - Feature List (Example)

**Status:** Accepted
**Date:** 2026-01-06
**Related FEAT:** `NA`

---
 
## Feature Overview

This ADR migrates the AI agent integration layer from legacy specs to Anthropic's Claude Skills specification, providing standards-compliant skill discovery and expanded AI guidance coverage.

---

## Core Features

### F1: Claude Skills Directory Structure

**Description:** AI guidance organized following Anthropic Claude Skills specification.

**Directory Structure:**
```
.claude/skills/
├── project-governance/
│   ├── SKILL.md (main skill definition with YAML frontmatter)
│   ├── references/ (supporting documentation)
│   ├── scripts/ (executable scripts)
│   └── assets/ (templates and resources)
├── requirements-engineering/
│   ├── SKILL.md
│   └── references/
├── environment-setup/
├── feature-development/
├── data-modeling/
├── api-development/
├── security-implementation/
├── testing-strategy/
├── issue-tracking/
└── deployment-automation/
```

**10 Skills (vs 7 legacy specs):**

| Skill Key | Category | Coverage |
|-----------|----------|----------|
| `project-governance` | governance | Constraints, ADRs, MCP config |
| `requirements-engineering` | requirements | Acceptance criteria, definition of done |
| `environment-setup` | foundation | IDE, CI/CD, package management |
| `feature-development` | features | User stories, UI/UX, shadcn components |
| `data-modeling` | data | DDD entities, aggregates, Prisma |
| `api-development` | api | Routes, services, integrations |
| `security-implementation` | security | Auth, authorization, compliance |
| `testing-strategy` | testing | Unit, integration, E2E testing |
| `issue-tracking` | tracking | Code reviews, bug management |
| `deployment-automation` | workflow | Git workflows, releases, changelog |

**Benefits:**
- Standards-compliant with Anthropic specification
- Expanded coverage (10 skills vs 7 legacy)
- Better organization by domain
- Easier to maintain and extend

---

### F2: YAML Frontmatter Metadata

**Description:** Each SKILL.md file includes YAML frontmatter with structured metadata.

**Frontmatter Structure:**
```yaml
---
name: Project Governance
category: governance
description: Manages project constraints, architecture decisions, and MCP configuration
triggers:
  - check constraints
  - governance exception
  - project standards
  - architectural decision
version: 1.0.0
author: Development Team
last_updated: 2026-01-06
---
```

**Metadata Fields:**
- `name` - Human-readable skill name
- `category` - Skill category/domain
- `description` - Brief description of skill purpose
- `triggers` - Phrases that should activate this skill
- `version` - Semantic version number
- `author` - Skill maintainer
- `last_updated` - Last modification date

**User Capabilities:**
- See skill metadata without reading full content
- Filter skills by category
- Search skills by trigger phrases
- Track skill versions
- Identify skill maintainers

---

### F3: Dynamic Skill Discovery

**Description:** Skills are discovered automatically by scanning `.claude/skills/` directory and parsing SKILL.md frontmatter.

**Discovery Process:**
1. Scan `.claude/skills/` directory
2. Find all subdirectories with SKILL.md file
3. Parse YAML frontmatter from each SKILL.md
4. Extract metadata (name, category, description, triggers)
5. Build skill registry

**User Capabilities:**
- Add new skill by creating directory with SKILL.md
- Skill automatically discovered on next load
- No code changes needed to add skills
- Skills can be versioned independently

**Technical Implementation:**
```typescript
function loadSkills(): Skill[] {
  const skillsDir = '.claude/skills/'
  const directories = fs.readdirSync(skillsDir)

  return directories
    .filter(dir => fs.existsSync(path.join(skillsDir, dir, 'SKILL.md')))
    .map(dir => {
      const content = fs.readFileSync(path.join(skillsDir, dir, 'SKILL.md'), 'utf-8')
      const metadata = parseYAMLFrontmatter(content)
      return { key: dir, ...metadata, content }
    })
}
```

---

### F4: Skill Loading API

**Description:** API endpoints for loading skill content and metadata.

**Get All Skills:**
```
GET /api/ai-agents/specs
```
Returns all skills with their content.

**Get Specific Skills:**
```
GET /api/ai-agents/specs?skills=project-governance,testing-strategy
```
Returns specified skills only.

**Get Skill Metadata:**
```
GET /api/ai-agents/metadata
```
Returns skill metadata (name, category, description, triggers) without full content.

**Response Format:**
```json
{
  "skills": [
    {
      "key": "project-governance",
      "name": "Project Governance",
      "category": "governance",
      "description": "Manages project constraints...",
      "triggers": ["check constraints", "governance exception"],
      "version": "1.0.0",
      "content": "# Project Governance\n\n..."
    }
  ],
  "total": 10
}
```

**Error Handling:**
- Invalid skill key → `404 Not Found`
- Old agent parameter (`?agents=`) → `400 Bad Request` with migration hint
- Missing skills directory → `500 Internal Server Error`

---

### F5: Skill Content Aggregation

**Description:** Skill content includes both SKILL.md and files from references/ directory.

**Content Aggregation:**
1. Load SKILL.md as primary content
2. Scan `references/` subdirectory
3. Include all markdown files
4. Concatenate in logical order
5. Return combined content

**Example:**
```
project-governance skill includes:
- SKILL.md (main skill definition)
- references/tech-stack-agent.md
- references/folder-structure-agent.md
- references/DOCUMENTATION-STANDARDS.md
```

**Benefits:**
- Progressive disclosure (can read just SKILL.md or full content)
- Organize related guidance in references
- Single API call gets all related content
- Easier to maintain (split into focused files)

---

### F6: Backward Compatibility Handling

**Description:** Old agent keys explicitly rejected with helpful error messages.

**Legacy Agent Keys (no longer supported):**
- `ai-instructions`
- `tech-stack`
- `folder-structure`
- `package-manager`
- `git-workflow`
- `documentation`
- `frontend`

**Error Response:**
```json
{
  "error": "Invalid skill key",
  "message": "Skill 'ai-instructions' not found. Did you mean 'project-governance'?",
  "validSkills": [
    "project-governance",
    "requirements-engineering",
    "environment-setup",
    ...
  ],
  "migrationGuide": "See admin-docs/decisions/ADR-002-migrate-agent-loader-to-claude-skills.md"
}
```

**User Experience:**
- Clear error message explaining migration
- Suggestions for replacement skills
- Link to migration guide
- List of valid skill keys

---

## Migration Mapping

### Legacy Specs → New Skills

**AI Instructions:**
```
Before: specs/AI-PROJECT-INSTRUCTIONS.md (agent key: ai-instructions)
After:  .claude/skills/project-governance/SKILL.md (skill key: project-governance)
```

**Tech Stack:**
```
Before: specs/tech-stack-agent.md (agent key: tech-stack)
After:  .claude/skills/project-governance/references/tech-stack-agent.md
```

**Folder Structure:**
```
Before: specs/folder-structure-agent.md (agent key: folder-structure)
After:  .claude/skills/project-governance/references/folder-structure-agent.md
```

**Package Manager:**
```
Before: specs/package-manager-agent.md (agent key: package-manager)
After:  .claude/skills/environment-setup/references/setup/package-manager-agent.md
```

**Git Workflow:**
```
Before: specs/commits-releases-changelog-agent.md (agent key: git-workflow)
After:  .claude/skills/deployment-automation/references/commits-releases-changelog-agent.md
```

**Documentation:**
```
Before: specs/DOCUMENTATION-STANDARDS.md (agent key: documentation)
After:  .claude/skills/project-governance/references/DOCUMENTATION-STANDARDS.md
```

**Frontend:**
```
Before: specs/FRONT-END-README.md (agent key: frontend)
After:  .claude/skills/feature-development/references/uiux/FRONT-END-README.md
```

---

## API Changes

### Query Parameter Update

**Before:**
```
GET /api/ai-agents/specs?agents=ai-instructions,tech-stack
```

**After:**
```
GET /api/ai-agents/specs?skills=project-governance,testing-strategy
```

**Breaking Change:**
- Old parameter name `agents` no longer accepted
- Old agent keys no longer valid
- API consumers must update to new format

**Migration Script:**
```bash
# Update API calls
sed -i 's/?agents=/?skills=/g' **/*.ts
sed -i 's/ai-instructions/project-governance/g' **/*.ts
sed -i 's/tech-stack/project-governance/g' **/*.ts
# ... etc for all old keys
```

---

## Integration Points

### With Claude Code

**Skill Discovery:**
- Claude Code CLI can discover skills in `.claude/skills/`
- Trigger phrases activate appropriate skills
- YAML frontmatter provides metadata for skill selection

**Skill Activation:**
```yaml
# Example trigger activation
triggers:
  - check constraints  # Phrase in user request
  - governance exception
  - project standards
```

When user says: "check constraints before implementing this feature"
→ Claude Code activates project-governance skill

### With DevFlow UI

**AI Agent Settings Page:**
- Lists all available skills
- Displays skill metadata (name, category, description)
- Allows selection of skills to load
- Shows skill version and last updated date

**Skill Content Viewer:**
- Displays full skill content
- Syntax highlighting for code blocks
- Collapsible reference sections
- Search within skill content

---

## Benefits Over Legacy System

**Standards Compliance:**
- Follows Anthropic Claude Skills specification
- Compatible with Claude Code tooling
- Future-proof for Anthropic updates

**Better Organization:**
- Clear category hierarchy
- Related skills grouped logically
- References separated from main skill definition

**Improved Discoverability:**
- YAML metadata enables efficient filtering
- Trigger phrases guide skill selection
- Categories help users find relevant skills

**Enhanced Maintainability:**
- Single source of truth (`.claude/skills/`)
- Easy to add new skills (just create directory)
- Version tracking per skill
- Clear author attribution

**Expanded Coverage:**
- 10 skills vs 7 legacy specs (43% more coverage)
- New domains: requirements engineering, security, testing
- More comprehensive AI guidance

---

## File Cleanup

**Deleted:**
- `src/lib/ai-agents/specs/AI-PROJECT-INSTRUCTIONS.md`
- `src/lib/ai-agents/specs/tech-stack-agent.md`
- `src/lib/ai-agents/specs/folder-structure-agent.md`
- `src/lib/ai-agents/specs/package-manager-agent.md`
- `src/lib/ai-agents/specs/commits-releases-changelog-agent.md`
- `src/lib/ai-agents/specs/DOCUMENTATION-STANDARDS.md`
- `src/lib/ai-agents/specs/FRONT-END-README.md`
- `src/lib/ai-agents/specs/` (entire directory)

**Preserved:**
- All legacy content moved to `.claude/skills/` under `references/`
- No content lost (just reorganized)

---

**Total Features:** 6 major features
**Total Skills:** 10 (vs 7 legacy)
**Total API Endpoints:** 2 (specs and metadata)
**Migration Status:** Complete (legacy specs deleted)
