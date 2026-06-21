# Feature Specifications

This directory contains feature specifications (FEAT) for the AI Agentic Automation skills framework.

---

## Overview

Feature specifications document **what we're building** at a high level. They capture the complete scope of a feature including its components, integration points, benefits, and acceptance criteria.

### Document Hierarchy

```
FEAT (Feature Spec)     ← WHAT we're building (this directory)
     │
     ├── ADR            ← WHY we made technical decisions
     │                    (@skills/requirements-engineering/references/decision-logs/)
     │
     ├── REQ            ← Acceptance criteria & requirements
     │                    (@skills/requirements-engineering/references/acceptance-criteria/)
     │
     └── ISS            ← Implementation issues/tasks
                          (admin-docs/issues/ or GitHub Issues)
```

---

## Directory Structure

```
admin-docs/features/
├── README.md                    # This file
├── _templates/
│   ├── FEAT-TEMPLATE.md         # Full feature specification template
│   └── FEAT-TEMPLATE-MINIMAL.md # Lightweight template for smaller features
├── active/                      # Features in development
├── completed/                   # Shipped features (archive)
├── proposed/                    # Features awaiting approval
└── rejected/                    # Rejected proposals (for reference)
```

---

## Feature Lifecycle

```
┌──────────┐    ┌──────────┐    ┌─────────────┐    ┌───────────┐
│ Proposed │───▶│ Accepted │───▶│ In Progress │───▶│ Completed │
└──────────┘    └──────────┘    └─────────────┘    └───────────┘
      │
      ▼
┌──────────┐
│ Rejected │
└──────────┘
```

| Status | Location | Description |
|--------|----------|-------------|
| **Proposed** | `proposed/` | Draft awaiting review/approval |
| **Accepted** | `active/` | Approved, ready for development |
| **In Progress** | `active/` | Currently being implemented |
| **Completed** | `completed/` | Shipped, archived for reference |
| **Rejected** | `rejected/` | Not approved (kept for context) |

---

## Naming Convention

```
FEAT-{NNN}-{kebab-case-title}.md
```

**Examples:**
- `FEAT-001-claude-skills-migration.md`
- `FEAT-002-codebase-analysis-reporting.md`
- `FEAT-003-admin-health-dashboard.md`

**Numbering:**
- Sequential, zero-padded (001, 002, 003...)
- Numbers are never reused, even for rejected features
- Check existing features before assigning a new number

---

## Creating a New Feature

### 1. Determine Scope

| Scope | Template | Use When |
|-------|----------|----------|
| **Full** | `FEAT-TEMPLATE.md` | Multi-component features, architectural changes, new skills |
| **Minimal** | `FEAT-TEMPLATE-MINIMAL.md` | Single-component enhancements, bug fixes with scope |

### 2. Create the Feature File

```bash
# Copy the appropriate template
cp admin-docs/features/_templates/FEAT-TEMPLATE.md \
   admin-docs/features/proposed/FEAT-XXX-your-feature-name.md
```

### 3. Fill Out Required Sections

**Minimum required sections:**
- Overview
- Problem Statement
- Core Features (at least one F# section)
- Acceptance Criteria
- Related Documents

### 4. Submit for Review

- Move to `proposed/` if draft
- Request review from maintainers
- Link any related ADRs or issues

### 5. Track Progress

Update the **Status** field as the feature progresses:
```markdown
**Status:** Proposed → Accepted → In Progress → Completed
```

---

## Feature Template Quick Reference

### Full Template Structure

```markdown
# FEAT-{NNN}: {Title}

**Status:** Proposed
**Date:** YYYY-MM-DD
**Author:** @username
**Related Skills:** @skills/{name}/
**Related ADRs:** ADR-###
**Related Issues:** #XX

## Overview
## Problem Statement
## Core Features
### F1: {Component Name}
### F2: {Component Name}
## Integration Points
## Migration / Upgrade Path
## Benefits
## Risks & Mitigations
## Dependencies
## Success Metrics
## Related Documents
## Changelog
```

### Minimal Template Structure

```markdown
# FEAT-{NNN}: {Title}

**Status:** Proposed
**Date:** YYYY-MM-DD
**Author:** @username

## Overview
## Problem Statement
## Solution
## Acceptance Criteria
## Related Documents
```

---

## Linking Features to Other Documents

### Linking to ADRs

```markdown
**Related ADRs:**
- [ADR-001: Technology Choice](../../.claude/skills/requirements-engineering/references/decision-logs/ADR-001-technology-choice.md)
```

### Linking to Skills

```markdown
**Related Skills:**
- `@skills/codebase-analysis/` - Primary skill this feature enhances
- `@skills/project-governance/` - Governance patterns referenced
```

### Linking to Issues

```markdown
**Related Issues:**
- [admin-docs/issues/skills/ISSUE-001.md](../issues/skills/ISSUE-001.md)
- GitHub Issue #123
```

---

## Feature Index

### Active Features

| ID | Title | Status | Owner |
|----|-------|--------|-------|
| <!-- Active features will be listed here --> |

### Completed Features

| ID | Title | Completed | Owner |
|----|-------|-----------|-------|
| FEAT-001 | [Claude Skills Migration](completed/FEAT-001-claude-skills-migration.md) | 2026-01-06 | Team |

### Proposed Features

| ID | Title | Proposed | Owner |
|----|-------|----------|-------|
| PROP-001 | [AI Analysis Service Layer with Probability Models](proposed/PROP-001-ADD-PROBABILITY-MODEL.md) | 2026-02-17 | @mrsdo |

---

## Best Practices

### DO

- Start with the problem statement, not the solution
- Break features into discrete components (F1, F2, F3...)
- Define clear acceptance criteria for each component
- Link to related ADRs for architectural decisions
- Update status as the feature progresses
- Archive completed features (don't delete)

### DON'T

- Skip the problem statement
- Combine unrelated functionality in one feature
- Leave acceptance criteria vague
- Forget to link related documents
- Delete rejected features (they provide context)

---

## Integration with Skills Framework

Features should align with the skills workflow sequence:

| Feature Type | Primary Skill | Prerequisite |
|--------------|---------------|--------------|
| New skill | `project-governance` | Governance approval |
| Skill enhancement | `{target-skill}` | Requirements review |
| Infrastructure | `environment-setup` | ADR for approach |
| Reporting/Analysis | `codebase-analysis` | Template review |
| Security | `security-implementation` | Security ADR |

---

## Related Documentation

| Document | Location | Purpose |
|----------|----------|---------|
| ADR Templates | `@skills/requirements-engineering/references/decision-logs/` | Architectural decisions |
| Acceptance Criteria | `@skills/requirements-engineering/references/acceptance-criteria/` | DoD templates |
| Issues | `admin-docs/issues/` | Implementation tracking |
| Skills Index | `skills/README.md` | All available skills |

---

**Version:** 1.0.0
**Last Updated:** 2026-01-16
**Maintainer:** Framework Team