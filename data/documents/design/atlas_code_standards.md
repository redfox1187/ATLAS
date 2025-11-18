# atlas code standards

**project:** atlas  
**status:** draft  
**version:** v0.1  
**last_updated:** 2025-11-18  

---

## 1. scope

This document defines standards for source code files in the ATLAS project.  
It focuses on:

- file-level headers
- file-level footers
- inline changelog usage
- relationships between code files and documentation

The examples in this document are written for GDScript (`.gd`), but the same concepts may be applied to other languages used in the project.

---

## 2. filenames and locations

Code filenames and directory layouts are governed by:

- `data/documents/design/atlas_filename_standards.md`

In summary:

- filenames use lowercase with underscores (`snake_case`).  
- code lives under `data/scripts/` in category folders (`player`, `npc`, `systems`, `ui`, `weapons`, `world`, etc.).  
- filenames should align with the scene or system they serve where there is a tight coupling.

Examples:

- `data/scripts/player/player_controller.gd`  
- `data/scripts/npc/humanoid_soldier_01.gd`  
- `data/scripts/systems/console_manager.gd`  
- `data/scripts/ui/debug_hud.gd`  

---

## 3. code file header

Every code file in ATLAS should begin with a structured header comment block.  
The header provides quick orientation, links to related documents, and a local changelog summary.

### 3.1 header format

Recommended header pattern for GDScript files:

```gdscript
# ============================================================================
# file: data/scripts/player/player_controller.gd
# project: atlas
# role: player controller
# summary: handles third-person player movement, input, and basic camera control.
# created: 2025-11-18
# last_updated: 2025-11-18
# version: v0.1
# related_docs:
#   - data/documents/design/atlas_player_controller_guide.md
#   - data/documents/reports/2025-11-18_atlas-report_player_controller_initial_v01.md
# changelog:
#   v0.1 (2025-11-18)
#     - initial implementation: movement, camera follow, basic input mapping.
# ============================================================================
```

Field meanings:

- `file`: project-relative path to this file.  
- `project`: the project name (always `atlas` for this repository).  
- `role`: short description of the file's primary responsibility.  
- `summary`: one-line explanation of what the file does.  
- `created`: date this file was first created.  
- `last_updated`: date of the most recent meaningful change.  
- `version`: local version identifier for the file (e.g. `v0.1`, `v0.2`, `v1.0`).  
- `related_docs`: list of relevant design documents, guides, or reports.  
- `changelog`: chronological list of version entries with brief patch-note style descriptions.

The decorator lines (`# ============================================================================`) provide a visually clear boundary for the header.  
A similar pattern is recommended for the footer (see section 4).

### 3.2 changelog usage

The `changelog` section should:

- list versions in chronological order (oldest first)  
- include the date and a short explanation for each entry  
- focus on meaningful changes: new features, refactors, behavior changes, and non-trivial bug fixes

Example additional entry:

```gdscript
# changelog:
#   v0.1 (2025-11-18)
#     - initial implementation: movement, camera follow, basic input mapping.
#   v0.2 (2025-11-22)
#     - refactored movement to support sprinting and crouching.
#     - adjusted camera follow to reduce jitter at high speeds.
```

Minor, purely cosmetic changes may be omitted from the changelog unless they are part of a larger update already being recorded.

---

## 4. code file footer

All code files in ATLAS must include a footer comment block.  
The footer confirms the file identity, version, and last update date and clearly marks the end of the file.

Recommended footer pattern:

```gdscript
# ============================================================================
# end_of_file: data/scripts/player/player_controller.gd
# version: v0.1
# last_updated: 2025-11-18
# ============================================================================
```

Requirements:

- `end_of_file` must reference the project-relative path to the file.  
- `version` and `last_updated` must match the values in the header.  
- The footer block must be the last content in the file.

The footer helps detect truncation or copy errors and simplifies side-by-side comparison when inspecting different versions of a file.

---

## 5. versioning rules

Code file versioning is coordinated with document standards but handled locally within each file.

### 5.1 when to bump version

Bump the `version` value when:

- adding a new feature inside the file  
- making a refactor that changes behavior or structure in a meaningful way  
- fixing a non-trivial bug that affects gameplay or systems

Update `last_updated` at the same time, and add a new entry to the `changelog` section describing:

- what changed  
- why it changed (when helpful)  
- any external impact (e.g. changed expectations for other systems)

Example bump:

```gdscript
# last_updated: 2025-11-22
# version: v0.2
# changelog:
#   v0.1 (2025-11-18)
#     - initial implementation: movement, camera follow, basic input mapping.
#   v0.2 (2025-11-22)
#     - refactored movement to support sprinting and crouching.
```

### 5.2 coordination with reports

For larger changes that span multiple files or represent a significant refactor, it is recommended to:

- create a report under `data/documents/reports/` documenting the work  
- reference that report in the `related_docs` section of each affected file

Example:

```gdscript
# related_docs:
#   - data/documents/reports/2025-11-23_atlas-report_player_movement_refactor_v01.md
```

This keeps individual file changelogs focused while centralizing detailed narrative in the report.

---

## 6. relationship to documentation

Code files should link to relevant documentation where appropriate, particularly when:

- implementing a system specified in a standards document  
- following a design described in a guide  
- being updated as part of a documented refactor or bug fix

Examples of related documents:

- `data/documents/design/atlas_player_controller_guide.md`  
- `data/documents/design/atlas_combat_standards.md`  
- `data/documents/reports/2025-11-18_atlas-report_player_controller_initial_v01.md`  

The `related_docs` header field is the primary place to list these references.

---

## 7. coordination with other standards

This document works together with:

- `data/documents/design/atlas_filename_standards.md`  
  - defines filename conventions and paths for code and other files.

- `data/documents/design/atlas_document_standards.md`  
  - defines structure, headers, and footers for Markdown documents, including reports.

Together, these three standards form the core of ATLAS file, code, and documentation structure.

---

## revision_history

- **v0.1 — 2025-11-18**  
  - initial draft of code standards for ATLAS, including headers, footers, and changelog usage.

---

file: data/documents/design/atlas_code_standards.md  
version: v0.1  
last_updated: 2025-11-18  
