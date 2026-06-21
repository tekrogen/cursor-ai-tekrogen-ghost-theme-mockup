---
feature-id: FEAT-SET-013
title: Custom Tags
status: Proposed
group: Household
priority: P3
backend-ready: No
date: 2026-03-12
monarch-ref: https://app.monarch.com/settings/tags
---

# FEAT-SET-013: Custom Tags

## Summary

Create a Tags settings page for defining custom transaction tags. Tags provide a secondary classification layer beyond categories — useful for tax tracking, reimbursements, and custom grouping.

## Monarch Reference

- User-defined tags: Social Security, Tax, Reimburse, etc.
- Tags applied to individual transactions
- Tag management: create, rename, delete
- Color coding per tag
- Usage count per tag

## EBIA Current State

- No Tag model in Prisma schema
- No tagging system on transactions
- Transaction model has no tags field

## Proposed Changes

### 1. Create Tags Settings Page

`app/(dashboard)/settings/tags/page.tsx`:

```
┌──────────────────────────────────────────────────┐
│  Tags                                             │
│  Create custom tags for organizing transactions   │
│                                        [+ Add Tag]│
│                                                   │
│  ┌────────────────────────────────────────────┐   │
│  │  ● Tax Deductible     23 transactions      │   │
│  │                              [Edit] [✕]    │   │
│  │  ● Reimbursable        8 transactions      │   │
│  │                              [Edit] [✕]    │   │
│  │  ● Business Expense   14 transactions      │   │
│  │                              [Edit] [✕]    │   │
│  │  ● Vacation            6 transactions      │   │
│  │                              [Edit] [✕]    │   │
│  └────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────┘
```

### 2. Tag Creation Dialog

- Name (required)
- Color picker (optional, from preset palette)
- Description (optional)

### 3. Placeholder State

Render page layout with "Coming soon" or allow tag creation even before transactions can be tagged — the tag definitions are useful for planning.

## Components

| Component | Status | Path |
|-----------|--------|------|
| `TagsSettingsPage` | New | `app/(dashboard)/settings/tags/page.tsx` |
| `TagList` | New | `components/settings/tag-list.tsx` |
| `TagEditDialog` | New | `components/settings/tag-edit-dialog.tsx` |

## Backend Requirements

- **Schema**: New Tag model + junction table:
  ```prisma
  model Tag {
    id           String          @id @default(cuid())
    name         String
    color        String?
    description  String?
    userId       String
    transactions TransactionTag[]
    createdAt    DateTime        @default(now())
    updatedAt    DateTime        @updatedAt
    @@unique([userId, name])
  }

  model TransactionTag {
    transactionId String
    tagId         String
    transaction   Transaction @relation(fields: [transactionId], references: [id])
    tag           Tag         @relation(fields: [tagId], references: [id])
    @@id([transactionId, tagId])
  }
  ```
- **API**: CRUD for tags
- **Transaction API**: Extend to support adding/removing tags

## Dependencies

- **FEAT-SET-001** (Settings Layout)
- Phase 3: Service Layer Foundation

## Acceptance Criteria

- [ ] `/settings/tags` shows list of user-defined tags with usage counts
- [ ] User can create, rename, delete tags
- [ ] Tags have optional color coding
- [ ] Delete confirmation when tag has associated transactions
- [ ] Placeholder state for pre-implementation
