# Z-ai-guard

> Layer: L2 — Rules, Procedures, Tools
> Owning standard: STD-META-001 v2.0
> Last Updated: 2026-06-17
> Status: **SKELETON — pending migration from anti-hallucination-guard (AHG) v2.5.0**

This repository will host the **enforcement layer** for the Z-ai ecosystem:
rules (what agents must do), procedures (what runs when a rule fires),
and tools (the scripts rules call).

## Repository Layout (planned)

```
Z-ai-guard/
├── AGENT_RULES.md            # All RULE-* declarations (HTML-comment header format)
├── rules/                    # Detailed rule docs (optional)
├── instructions/             # PROC-* procedure docs
├── scripts/                  # PROC-* executable scripts (.sh, .js)
├── tools/                    # TOOL-* tools (verify-docs, etc.)
├── registry.json             # Authoritative RULE/PROC/TOOL registry
├── MIGRATIONS.md             # ID migrations for this repo
└── README.md                 # This file
```

## Migration Plan (from AHG v2.5.0)

Per STD-META-001 §11.2, the existing 17 rules in
`anti-hallucination-guard/AGENT_RULES.md` (RULE-001..RULE-017) will be
renamed to domain-prefixed IDs:

| Legacy | New ID | Rule Name |
|---|---|---|
| RULE-001 | RULE-ANSWER-001 | Answer Before Act |
| RULE-002 | RULE-WORKLOG-002 | Worklog before/after |
| RULE-003 | RULE-READ-003 | Read before write |
| RULE-004 | RULE-COMMIT-004 | One logical block per commit |
| RULE-005 | RULE-LOOPS-005 | No loops |
| RULE-006 | RULE-HONEST-006 | Honest reporting |
| RULE-007 | RULE-STRUCT-007 | Work structure |
| RULE-008 | RULE-ENV-008 | Sandbox verification |
| RULE-009 | RULE-AGENT-009 | Session start protocol |
| RULE-010 | RULE-DOC-010 | Documentation sync |
| RULE-011 | RULE-INTEGRITY-011 | Integrity protection |
| RULE-012 | RULE-MONOLITH-012 | Anti-monolith (250 lines) |
| RULE-013 | RULE-VERSION-013 | Use verify-docs bump |
| RULE-014 | RULE-COMMIT-014 | Pre-commit checklist |
| RULE-015 | RULE-DOC-015 | No Unicode graphics |
| RULE-016 | RULE-ARCH-016 | Submodule immutability |
| RULE-017 | RULE-ARCH-017 | Upstream write protection |

Migration window opens at v3.0.0; legacy IDs resolvable until v4.0.0.

## Procedures (PROC-)

| ID | File | Version | Level | Status |
|---|---|---|---|---|
| PROC-SETUP-001 | setup.sh | 2.0 | [C] | ACTIVE (in AHG, pending migration) |
| PROC-UPDATE-002 | update.sh | 2.1 | [C] | ACTIVE (in AHG, pending migration) |
| PROC-COCHANGE-003 | scripts/co-change-check.sh | 1.0 | [C] | ACTIVE (in AHG, pending migration) |
| PROC-LINECOUNT-004 | scripts/line-count-check.sh | 1.0 | [C] | ACTIVE (in AHG, pending migration) |

## Tools (TOOL-)

| ID | File | Version | Level | Status |
|---|---|---|---|---|
| TOOL-VERIFY-001 | tools/verify-docs/ | 2.1 | [C] | ACTIVE (in AHG, pending migration) |
| TOOL-BUMP-005 | tools/verify-docs/src/bump.ts | 2.1 | [C] | ACTIVE (in AHG, pending migration) |

## Status

This repo is a skeleton. The actual content migration from
`/home/z/my-project/_research/anti-hallucination-guard/` will be done
as a separate task after the standards layer is finalized.
