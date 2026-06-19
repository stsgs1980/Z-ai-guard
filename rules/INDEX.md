# RULE-MONOLITH-001..017 — Rule Index

> Source: Anti-Hallucination-Guard v2.5.0
> Migration: M002 (see Z-ai-standards/MIGRATIONS.md)
> Owning standard: STD-META-001 v2.0.2
> Last Updated: 2026-06-19

All 17 rules migrated from AHG `AGENT_RULES.md` RULE-001..017.
ID references inside rule bodies have been rewritten:
- `RULE-XXX` → `RULE-MONOLITH-XXX`
- `PROC-XXX` → `PROC-MONOLITH-XXX`
- `TOOL-XXX` → `TOOL-MONOLITH-XXX`
- `STD-ENV-XXX` → kept as-is (pending separate migration)

## Rule Catalog

| ID | Title | Version | Level | Source |
|---|---|---|---|---|
| RULE-MONOLITH-001 | Answer before act (no unsolicited action) | v1.0 | critical | AHG RULE-001 |
| RULE-MONOLITH-002 | worklog -- BEFORE and AFTER every action | v1.0 | critical | AHG RULE-002 |
| RULE-MONOLITH-003 | Read before write | v1.0 | critical | AHG RULE-003 |
| RULE-MONOLITH-004 | One logical block -- one commit | v1.0 | critical | AHG RULE-004 |
| RULE-MONOLITH-005 | No loops | v1.0 | critical | AHG RULE-005 |
| RULE-MONOLITH-006 | Honest reporting | v1.0 | critical | AHG RULE-006 |
| RULE-MONOLITH-007 | Work structure | v1.0 | warning | AHG RULE-007 |
| RULE-MONOLITH-008 | Sandbox verification (no fake setup) | v1.0 | critical | AHG RULE-008 |
| RULE-MONOLITH-009 | Session Start Protocol (drift prevention) | v1.0 | critical | AHG RULE-009 |
| RULE-MONOLITH-010 | Documentation sync (no code without docs) | v1.0 | critical | AHG RULE-010 |
| RULE-MONOLITH-011 | Integrity protection (no self-sabotage) | v1.0 | critical | AHG RULE-011 |
| RULE-MONOLITH-012 | Anti-monolith (file size by category) | v1.2 | critical | AHG RULE-012 |
| RULE-MONOLITH-013 | Use ahg bump for version updates | v1.1 | critical | AHG RULE-013 |
| RULE-MONOLITH-014 | Pre-commit mandatory checklist | v1.1 | critical | AHG RULE-014 |
| RULE-MONOLITH-015 | No Unicode graphics (UNICODE_POLICY compliance) | v1.0 | warning | AHG RULE-015 |
| RULE-MONOLITH-016 | AHG submodule is immutable architecture (no removal, no inlining) | v1.0 | critical | AHG RULE-016 |
| RULE-MONOLITH-017 | Upstream write protection (no consumer agent may push to AHG) | v1.0 | critical | AHG RULE-017 |

## Related Migrations

- **M002**: Rename RULE-001..017 → RULE-MONOLITH-001..017 (this migration, COMPLETE)
- **Pending**: Migrate AHG PROC-XXX → PROC-MONOLITH-XXX (5 procedures)
- **Pending**: Migrate AHG TOOL-XXX → TOOL-MONOLITH-XXX (3 tools)
- **Pending**: Migrate AHG STD-ENV-001/002 → STD-ENV-001/002 (2 standards)

