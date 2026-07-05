---
id: RULE-COMMIT-004
title: One logical block -- one commit
version: 1.0
level: [C]
status: ACTIVE
source: AHG v2.5.0 (RULE-004)
owning-standard: STD-META-001 v2.0
last-updated: 2026-06-17
related:
  - RULE-MONOLITH-002
---

# RULE-COMMIT-004: One logical block -- one commit

- Finished a meaningful chunk of work -> git add -A && git commit
- Commit message: specific description (not "update", not "fix")
- Commit without updated worklog -> ERROR (pre-commit hook will block)
