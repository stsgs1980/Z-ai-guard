# Z-ai-guard

> Layer: L2 — Rules, Procedures, Tools
> Owning standard: STD-META-001 v2.0
> Last Updated: 2026-06-19
> Status: **PARTIAL — RULE migration complete (M002); PROC + TOOL migration pending (M003, M004)**

This repository hosts the **enforcement layer** for the Z-ai ecosystem:
rules (what agents must do), procedures (what runs when a rule fires),
and tools (the scripts rules call).

## Current state (audited 2026-06-19)

| Component   | Count | Status                                                                                          |
|-------------|-------|-------------------------------------------------------------------------------------------------|
| RULE-MONOLITH-* | 17/17 | ✅ Migrated (M002). Files in `rules/`, index in `rules/INDEX.md`.                              |
| PROC-*      | 0/4   | ❌ Pending M003. 4 IDs registered in STD-META-001 §4.14 but files not yet created.              |
| TOOL-*      | 0/2   | ❌ Pending M004. 2 IDs registered in STD-META-001 §4.15 but files not yet created.              |
| instructions/ | 0   | ❌ Not started. Planned as procedure doc files.                                                  |
| scripts/    | 0     | ❌ Not started. Planned as PROC-* executable scripts.                                            |
| tools/      | 0     | ❌ Not started. Planned as TOOL-* scripts.                                                       |
| registry.json | 0   | ❌ Not started. Planned as authoritative RULE/PROC/TOOL registry.                                |
| MIGRATIONS.md | 0   | ❌ Not started. Migrations currently tracked in `Z-ai-standards/MIGRATIONS.md`.                  |

**Net enforcement coverage**: rules are *declared* but the procedures and
tools they reference do not exist. Pre-commit + CI run only the L1
verifiers (`verify-standards.js`, `verify-id-graph.js`) — they do **not**
run any L2 procedure. See "Known inconsistencies" below.

## Repository layout (actual)

```
Z-ai-guard/
├── README.md                  # This file
└── rules/
    ├── INDEX.md               # Rule catalog (M002 mapping table)
    ├── RULE-MONOLITH-001.md   # Answer before act
    ├── RULE-MONOLITH-002.md   # Worklog before/after
    ├── RULE-MONOLITH-003.md   # Read before write
    ├── RULE-MONOLITH-004.md   # One logical block per commit
    ├── RULE-MONOLITH-005.md   # No loops
    ├── RULE-MONOLITH-006.md   # Honest reporting
    ├── RULE-MONOLITH-007.md   # Work structure
    ├── RULE-MONOLITH-008.md   # Sandbox verification
    ├── RULE-MONOLITH-009.md   # Session Start Protocol
    ├── RULE-MONOLITH-010.md   # Documentation sync
    ├── RULE-MONOLITH-011.md   # Integrity protection
    ├── RULE-MONOLITH-012.md   # Anti-monolith (250 lines)
    ├── RULE-MONOLITH-013.md   # Use ahg bump for version updates
    ├── RULE-MONOLITH-014.md   # Pre-commit mandatory checklist
    ├── RULE-MONOLITH-015.md   # No Unicode graphics
    ├── RULE-MONOLITH-016.md   # Submodule immutability
    └── RULE-MONOLITH-017.md   # Upstream write protection
```

## Repository layout (planned, after M003 + M004)

```
Z-ai-guard/
├── AGENT_RULES.md             # All RULE-* declarations (HTML-comment header format)
├── rules/                     # ✅ EXISTS — detailed rule docs
├── instructions/              # PROC-* procedure docs (.md)
├── scripts/                   # PROC-* executable scripts (.sh, .js)
├── tools/                     # TOOL-* tools (verify-docs, etc.)
├── registry.json              # Authoritative RULE/PROC/TOOL registry
├── MIGRATIONS.md              # ID migrations scoped to this repo
└── README.md
```

## Migration plan (from AHG v2.5.0)

Per STD-META-001 §11.2 and `Z-ai-standards/MIGRATIONS.md`:

### M002 — RULE-001..RULE-017 → RULE-MONOLITH-001..RULE-MONOLITH-017 (COMPLETE)

| Legacy       | New ID               | Rule Name                                  |
|--------------|----------------------|--------------------------------------------|
| RULE-001     | RULE-MONOLITH-001    | Answer Before Act                          |
| RULE-002     | RULE-MONOLITH-002    | Worklog before/after                       |
| RULE-003     | RULE-MONOLITH-003    | Read before write                          |
| RULE-004     | RULE-MONOLITH-004    | One logical block per commit               |
| RULE-005     | RULE-MONOLITH-005    | No loops                                   |
| RULE-006     | RULE-MONOLITH-006    | Honest reporting                           |
| RULE-007     | RULE-MONOLITH-007    | Work structure                             |
| RULE-008     | RULE-MONOLITH-008    | Sandbox verification                       |
| RULE-009     | RULE-MONOLITH-009    | Session start protocol                     |
| RULE-010     | RULE-MONOLITH-010    | Documentation sync                         |
| RULE-011     | RULE-MONOLITH-011    | Integrity protection                       |
| RULE-012     | RULE-MONOLITH-012    | Anti-monolith (250 lines)                  |
| RULE-013     | RULE-MONOLITH-013    | Use verify-docs bump                       |
| RULE-014     | RULE-MONOLITH-014    | Pre-commit checklist                       |
| RULE-015     | RULE-MONOLITH-015    | No Unicode graphics                        |
| RULE-016     | RULE-MONOLITH-016    | Submodule immutability                     |
| RULE-017     | RULE-MONOLITH-017    | Upstream write protection                  |

**Migration window**: documented as "NOT YET OPEN" in
`Z-ai-standards/MIGRATIONS.md` because legacy `RULE-001..RULE-017` IDs do
not exist anywhere in the current ID graph (AHG upstream is not a
tracked submodule). The new IDs are already active; the window will
formally open only if/when AHG content is imported.

### M003 — AHG PROC-XXX → PROC-MONOLITH-XXX (PENDING)

Not yet entered in `Z-ai-standards/MIGRATIONS.md`. Planned mapping:

| ID (in META-001 §4.14) | File (planned)                       | Version | Level | Implements rule        |
|------------------------|--------------------------------------|---------|-------|------------------------|
| PROC-SETUP-001         | scripts/setup.sh                     | 2.0     | [C]   | RULE-MONOLITH-008      |
| PROC-UPDATE-002        | scripts/update.sh                    | 2.1     | [C]   | RULE-MONOLITH-013      |
| PROC-COCHANGE-003      | scripts/co-change-check.sh           | 1.0     | [C]   | RULE-MONOLITH-010      |
| PROC-LINECOUNT-004     | scripts/line-count-check.sh          | 1.0     | [C]   | RULE-MONOLITH-012      |

### M004 — AHG TOOL-XXX → TOOL-MONOLITH-XXX (PENDING)

Not yet entered in `Z-ai-standards/MIGRATIONS.md`. Planned mapping:

| ID (in META-001 §4.15) | File (planned)                       | Version | Level | Used by rules                    |
|------------------------|--------------------------------------|---------|-------|----------------------------------|
| TOOL-VERIFY-001        | tools/verify-docs/                   | 2.1     | [C]   | RULE-MONOLITH-009, 010, 014      |
| TOOL-BUMP-005          | tools/verify-docs/src/bump.ts        | 2.1     | [C]   | RULE-MONOLITH-013                |

## Procedures (PROC-)

| ID                | File (planned)              | Version | Level | Status                              |
|-------------------|------------------------------|---------|-------|-------------------------------------|
| PROC-SETUP-001    | scripts/setup.sh             | 2.0     | [C]   | PENDING migration (M003)            |
| PROC-UPDATE-002   | scripts/update.sh            | 2.1     | [C]   | PENDING migration (M003)            |
| PROC-COCHANGE-003 | scripts/co-change-check.sh   | 1.0     | [C]   | PENDING migration (M003)            |
| PROC-LINECOUNT-004| scripts/line-count-check.sh  | 1.0     | [C]   | PENDING migration (M003)            |

## Tools (TOOL-)

| ID              | File (planned)               | Version | Level | Status                              |
|-----------------|-------------------------------|---------|-------|-------------------------------------|
| TOOL-VERIFY-001 | tools/verify-docs/            | 2.1     | [C]   | PENDING migration (M004)            |
| TOOL-BUMP-005   | tools/verify-docs/src/bump.ts | 2.1     | [C]   | PENDING migration (M004)            |

> **Note**: TOOL-VERIFY-002 (`verify-standards.js`), TOOL-VERIFY-004
> (`verify-id-graph.js`) and TOOL-CHECKUPDATES-006 (`check-updates.sh`)
> live in **Z-ai-standards/scripts/**, not in this repo. They are
> already implemented and active. TOOL-VERIFY-003 (`verify-cascade.js`)
> was RETIRED 2026-06-18.

## Known inconsistencies (as of 2026-06-19)

These are **real reference bugs** that need cleanup alongside M003/M004:

### 1. Phantom IDs in STD-META-001 §4.14 / §4.15

STD-META-001 lists PROC-SETUP-001, PROC-UPDATE-002, PROC-COCHANGE-003,
PROC-LINECOUNT-004, TOOL-VERIFY-001, TOOL-BUMP-005 with status `ACTIVE`
pointing at `Z-ai-guard/...` paths — but those files do not exist in
this repo. Until M003/M004 land, those rows should read
`ACTIVE (planned)` or `PENDING migration`, matching how
PROC-PLATFORM-INSTALL-005/006/007 are already marked.

### 2. Dangling Related: edges in 5 rules

Five rules reference IDs that **do not match the ID format**
(`<PREFIX>-<DOMAIN>-<NNN>` requires 3 digits) and are therefore
**silently dropped** by `verify-id-graph.js` (regex
`\b(STD|RULE|PROC|TOOL|ZAI)-[A-Z]+-\d{3}\b`):

| Rule              | Dangling reference        | Should resolve to (after M003/M004)        |
|-------------------|---------------------------|---------------------------------------------|
| RULE-MONOLITH-009 | `TOOL-MONOLITH-VERIFY`    | `TOOL-VERIFY-001`                           |
| RULE-MONOLITH-010 | `TOOL-MONOLITH-VERIFY`    | `TOOL-VERIFY-001`                           |
| RULE-MONOLITH-011 | `PROC-MONOLITH-SETUP`     | `PROC-SETUP-001`                            |
| RULE-MONOLITH-012 | `PROC-MONOLITH-LINECOUNT` | `PROC-LINECOUNT-004`                        |
| RULE-MONOLITH-013 | `TOOL-MONOLITH-BUMP`      | `TOOL-BUMP-005`                             |
| RULE-MONOLITH-014 | `TOOL-MONOLITH-VERIFY`    | `TOOL-VERIFY-001`                           |

Result: the ID-graph verifier reports `13/13 HARD PASS` — but the pass
is on the *graph that survived filtering*, not on the rules as written.
This is a structural assurance, not a semantic one. Fixing it requires
either (a) landing M003/M004 with the proper `<DOMAIN>-<NNN>` IDs and
updating the rule Related: lists, or (b) extending the verifier to flag
non-matching ID-shaped tokens in Related: fields.

### 3. `instructions/` directory mentioned in 3 places, content is 0

The README of Z-ai-platform (parent) lists `guard/instructions/` in its
repository-layout block. STD-ARCH-001 §6.2 lists `guard/procedures/*.md`
as the canonical location for PROC-* docs. Neither directory exists yet.
M003 should create `instructions/` (or `procedures/` — naming TBD) and
populate it with one .md per PROC-*.

## Status summary

This repo currently holds the **policy text** (17 rules) but not the
**enforcement runtime** (procedures, tools). Pre-commit + CI enforce
L1 (standards) only. L2 enforcement will activate after M003 + M004
land and the dangling references in section 2 above are rewritten to
the proper `<DOMAIN>-<NNN>` IDs.
