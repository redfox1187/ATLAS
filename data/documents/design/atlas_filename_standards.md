# atlas filename standards

**project:** atlas  
**status:** draft  
**version:** v0.1  
**last_updated:** 2025-11-18  

---

## 1. scope

This document defines filename conventions for the ATLAS project.  
It applies to:

- source code files
- Godot scenes and resources
- documentation files
- reports stored in the repository

The goal is to keep names predictable, searchable, and consistent across the project.

---

## 2. general rules

- filenames must use **lowercase letters** and **underscores** (`snake_case`).  
- avoid spaces, mixed case, and special characters.  
- digits are allowed where meaningful (e.g. `player_female_01`).  
- file extensions follow normal conventions (`.gd`, `.tscn`, `.md`, `.png`, etc.).  
- filenames should be descriptive enough to understand purpose without being excessively long.

Examples:

- `player_controller.gd`  
- `humanoid_soldier_01.tscn`  
- `atlas_directory_standards.md`  
- `level_mission01_city_block.tscn`  

---

## 3. documentation filenames

Documentation filenames for ATLAS follow these rules:

- all lowercase with underscores.  
- no dates or version numbers in the filename.  
- the word `atlas` may appear as a prefix when useful to clarify scope.

### 3.1 design documents

Path:

- `data/documents/design/`

Naming pattern:

- `atlas_<topic>_standards.md` for standards documents.  
- `atlas_<topic>_guide.md` for guides and how-to documents.

Examples:

- `atlas_directory_standards.md`  
- `atlas_document_standards.md`  
- `atlas_code_standards.md`  
- `atlas_player_controller_guide.md`  
- `atlas_combat_standards.md`  

### 3.2 notes

Path:

- `data/documents/notes/`

Naming pattern:

- `atlas_<topic>_notes.md` for general design and idea notes.  
- shorter slugs may be used where the context is obvious.

Examples:

- `atlas_weapon_system_notes.md`  
- `atlas_npc_behavior_notes.md`  
- `atlas_level_blockout_notes.md`  

### 3.3 qorders

The central collaboration brief is:

- path: repository root  
- filename: `qorders.md`

This file acts as the primary entry point for understanding how to work within the ATLAS project.  
Other documents and standards may be referenced from `qorders.md` but should not duplicate its purpose.

---

## 4. report filenames

Reports are special-purpose documents that capture specific work sessions, investigations, refactors, or contextual narratives.  
Reports are **not** read by Godot at runtime and are intended purely for human reference.

Path:

- `data/documents/reports/`

Reports follow the **old FQX** filename convention, which includes:

- ISO date prefix (`YYYY-MM-DD`)  
- project slug (`atlas`)  
- type (`report`)  
- short slug describing the topic  
- version suffix (`_vNN`)

Pattern:

- `YYYY-MM-DD_atlas-report_<slug>_vNN.md`

Examples:

- `2025-11-18_atlas-report_player_controller_initial_v01.md`  
- `2025-11-20_atlas-report_npc_ai_spike_v02.md`  
- `2025-11-22_atlas-report_console_and_debug_hud_pass_v01.md`  

The report filename itself is responsible for conveying date, topic, and version.  
Additional metadata and detailed context are provided inside the report file body.

---

## 5. code filenames

Code filenames should:

- follow `snake_case`  
- be short but descriptive  
- closely align with the scene or system they serve when there is a tight coupling

### 5.1 gdscript files

Path examples:

- `data/scripts/player/`  
- `data/scripts/npc/`  
- `data/scripts/systems/`  
- `data/scripts/ui/`  
- `data/scripts/weapons/`  
- `data/scripts/world/`  

Examples:

- `player_controller.gd`  
- `humanoid_soldier_01.gd`  
- `console_manager.gd`  
- `debug_hud.gd`  
- `weapon_rifle_standard.gd`  
- `world_mission01_city_block.gd`  

Scripts that act as shared systems or managers should be named according to their role:

- `event_bus.gd`  
- `inventory_system.gd`  
- `save_manager.gd`  

### 5.2 scene files

Scene filenames should mirror the naming of the entities they represent and follow the same `snake_case` rules.

Examples:

- `player_controller.tscn`  
- `humanoid_soldier_01.tscn`  
- `weapon_rifle_standard.tscn`  
- `world_mission01_city_block.tscn`  
- `test_movement_sandbox.tscn`  

Test and sandbox scenes should include the word `test` or `sandbox` in the filename for clarity.

---

## 6. asset filenames (high-level)

Asset naming can vary somewhat by content type, but the following general rules apply:

- use lowercase with underscores  
- include a category or role prefix where helpful (e.g. `wpn_`, `char_`, `env_`)  
- keep related files grouped by a consistent base name (e.g. textures for the same asset)

Examples:

- models:
  - `char_player_female_01_body.glb`
  - `wpn_rifle_standard.glb`
  - `env_wall_panel_a.glb`

- textures:
  - `char_player_female_01_body_albedo.png`
  - `wpn_rifle_standard_normal.png`
  - `env_wall_panel_a_roughness.png`

- materials:
  - `char_player_female_01_body_material.tres`
  - `wpn_rifle_standard_material.tres`

More detailed per-category asset standards may be defined in future documents (for example, a dedicated material and texture naming standard).

---

## 7. relationship to other standards

- For document structure (headers, body layout, footers, revision history), see:  
  `data/documents/design/atlas_document_standards.md`

- For code file headers, footers, and changelog conventions, see:  
  `data/documents/design/atlas_code_standards.md`

These three documents (`atlas_filename_standards.md`, `atlas_document_standards.md`, `atlas_code_standards.md`) are intended to be maintained together as a coherent manual for ATLAS file and documentation handling.

---

## revision_history

- **v0.1 — 2025-11-18**  
  - initial draft of filename standards for ATLAS, including project docs, reports, code, and assets.

---

file: data/documents/design/atlas_filename_standards.md  
version: v0.1  
last_updated: 2025-11-18  
