# RULE-MONOLITH-012: Anti-monolith (no file over 250 lines)

---
id: RULE-MONOLITH-012
title: Anti-monolith (no file over 250 lines)
version: 1.1
level: [C]
status: ACTIVE
source: AHG v2.5.0 (RULE-012)
owning-standard: STD-META-001 v2.0
last-updated: 2026-06-17
related:
  - RULE-MONOLITH-004
  - PROC-MONOLITH-LINECOUNT
---

Every file MUST stay under 250 lines. When a file crosses this threshold,
the agent MUST stop writing, split the file, and continue with smaller modules.

**This rule is enforced by the pre-commit hook (Phase 4).**
Violations are BLOCKED automatically -- the commit will not succeed.

**Thresholds:**
- File: 250 lines hard limit (150 recommended)
- Function: 50 lines max (longer = extract helper)
- One file = one responsibility

**Auto-activation (MUST NOT wait to be asked):**
1. Agent writes a file that approaches 250 lines -> STOP, split, continue
2. Agent opens a file that already exceeds 250 lines -> split before editing
3. Agent plans a new file that will clearly exceed limits -> plan decomposition upfront

**When threshold is crossed:**
1. STOP writing immediately
2. Announce: `[ANTI-MONOLITH] Threshold exceeded: <file> is N lines (limit 250)`
3. Identify sub-responsibilities within the file
4. Extract each into a separate file with a clear single purpose
5. Keep original as thin orchestrator that imports extracted modules
6. Continue the task with decomposed structure

**Valid exceptions (must be documented with comment in file):**
- Auto-generated code (Prisma schema, OpenAPI types)
- Configuration files that are naturally flat
- Files between 250-300 lines AND well-organized with clear sections

**Invalid exceptions:**
- File exceeds 400 lines (no excuses, decompose)
- "I'll refactor later" (later never comes)
- "It's easier to read in one file" (that's what imports are for)

<!-- ID: RULE-MONOLITH-013 | ver:1.1 | Level: C | Related: TOOL-MONOLITH-BUMP -->
