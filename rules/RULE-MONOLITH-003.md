# RULE-MONOLITH-003: Read before write

---
id: RULE-MONOLITH-003
title: Read before write
version: 1.0
level: [C]
status: ACTIVE
source: AHG v2.5.0 (RULE-003)
owning-standard: STD-META-001 v2.0
last-updated: 2026-06-17
related:
  - RULE-MONOLITH-010
---

- NEVER write a file without reading it first (Read tool)
- Exception: if file does not exist (verify via LS/Glob)
- Reason: without reading, agent risks destroying existing code

<!-- ID: RULE-MONOLITH-004 | ver:1.0 | Level: C | Related: RULE-MONOLITH-002 -->
