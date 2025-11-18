# atlas directory standards

**project:** atlas  
**status:** draft  
**version:** v0.1  
**last_updated:** 2025-11-18  

---

## 1. scope

This document defines the directory layout for the ATLAS Godot project.  
It describes the intended purpose of each major folder and how content is organized within them.

The goal is to keep structure predictable so that code, assets, and documents can be located and extended consistently.

---

## 2. top-level structure

At the project root, the main directories are:

- `addons/`  
  Third-party or custom Godot addons. Managed separately from core game code and content.

- `audio/`  
  All audio assets: sound effects, ambient sounds, and music.

- `data/`  
  Game-facing data and logic: scenes, scripts, and documents.

- `visual/`  
  Visual assets: 3D models, textures, materials, animations, and GUI art.

Other Godot-specific files (such as `project.godot`, `icon.svg`, and their import metadata) remain at the project root.

---

## 3. audio

Path:

- `audio/`

Purpose:

- contain all audio assets grouped by function and context.

Substructure:

- `audio/ambient/`  
  Long-form ambient loops, environmental beds, and background soundscapes.

- `audio/bgm/`  
  Background music and musical themes.

- `audio/sfx/`  
  General sound effects, further divided into:

  - `audio/sfx/gear/` – equipment, armor rustle, reloads not covered by weapon-specific sounds.  
  - `audio/sfx/ui/` – interface sounds, clicks, confirmations, error beeps, notifications.  
  - `audio/sfx/voice/` – voice lines, barks, and vocalizations.  
  - `audio/sfx/weapons/` – weapon fire, reloads, mechanical actions, impacts.  
  - `audio/sfx/world/` – environmental one-shots (doors, debris, switches, machinery).

Audio files may follow their own detailed naming standards in a dedicated document if needed.  
The directory structure above should be considered the canonical layout for ATLAS audio assets.

---

## 4. data

Path:

- `data/`

Purpose:

- contain game data and logic, including scenes, scripts, and project documentation.

Substructure:

- `data/documents/`  
  Design documents, standards, notes, and reports.  
  Further divided into:

  - `data/documents/design/` – standards, guides, and other design-facing documents.  
  - `data/documents/notes/` – exploratory notes and brainstorming.  
  - `data/documents/reports/` – session reports, refactor logs, and contextual write-ups.

  Document naming and structure are defined in:  
  `data/documents/design/atlas_document_standards.md`  
  and  
  `data/documents/design/atlas_filename_standards.md`.

- `data/scenes/`  
  Godot scenes that define game entities, UI, and world structures.

  Subfolders:

  - `data/scenes/player/`  
    Player avatar roots, controllers, and directly player-focused scenes.

  - `data/scenes/npc/`  
    NPC root scenes for AI-controlled characters (humanoids and creatures).

  - `data/scenes/props/`  
    Props and interactive objects, including architectural pieces treated as props (doors, panels, terminals, turrets, destructibles).

  - `data/scenes/ui/`  
    UI scenes: HUD, menus, overlays, console, debug HUD, and other interface elements.

  - `data/scenes/weapons/`  
    Weapon scenes, weapon rigs, muzzle flashes, and related prefabs.

  - `data/scenes/world/`  
    World and level root scenes. Levels are composed primarily by instancing scenes from `player/`, `npc/`, `props/`, `ui/`, and `weapons/`.

  Additional subfolders such as `tests/` may be created under these categories to isolate experimental or sandbox scenes (e.g. `data/scenes/world/tests/`).

- `data/scripts/`  
  GDScript and other code files for game logic.

  Subfolders mirror the scene categories and include systems:

  - `data/scripts/player/` – player logic, input handling, camera control, movement.  
  - `data/scripts/npc/` – AI behaviors, perception, decision-making, state machines.  
  - `data/scripts/props/` – interactive object logic, triggers, doors, terminals, environmental hazards.  
  - `data/scripts/ui/` – HUD logic, menus, console UI, debug HUD behavior.  
  - `data/scripts/weapons/` – weapon mechanics, firing logic, recoil, ammunition handling.  
  - `data/scripts/world/` – level scripting, mission flow, world state management.  
  - `data/scripts/systems/` – global systems and utilities (autoloads, event bus, save/load management, inventory, console backend, etc.).

  Code file headers, footers, and changelog usage are defined in:  
  `data/documents/design/atlas_code_standards.md`.

---

## 5. visual

Path:

- `visual/`

Purpose:

- organize all visual assets for ATLAS, including 3D content and GUI art.

---

### 5.1 3d assets

Path:

- `visual/3d/`

Subfolders:

- `visual/3d/animations/`  
  Animation data for 3D models.

  - `visual/3d/animations/humanoids/` – humanoid rigs and shared humanoid animation sets.

  Additional subfolders (`creatures/`, weapon-specific animations, etc.) may be added as needed, following the same pattern.

- `visual/3d/models/`  
  3D model files, grouped by role:

  - `visual/3d/models/creatures/` – non-humanoid rigs (animals, monsters, aliens).  
  - `visual/3d/models/humanoids/` – humanoid rigs that share a compatible skeleton.  
    - Example: `visual/3d/models/humanoids/player_female_01/` for a specific player body type.  
  - `visual/3d/models/props/` – props and environmental meshes.  
    Suggested subfolders inside `props/`:
    - `visual/3d/models/props/architecture/` – structural pieces (walls, buildings, corridors).  
    - `visual/3d/models/props/indoor/` – interior props and clutter.  
    - `visual/3d/models/props/outdoor/` – exterior props and street-level clutter.  
    - `visual/3d/models/props/terrain/` – terrain pieces, rocks, natural features.

  - `visual/3d/models/weapons/` – weapon meshes, attachments, and related model pieces.

- `visual/3d/materials/`  
  Godot material resources, mirroring the models structure:

  - `visual/3d/materials/creatures/`  
  - `visual/3d/materials/humanoids/`  
    - `visual/3d/materials/humanoids/player_female_01/`  
  - `visual/3d/materials/props/`  
    - `visual/3d/materials/props/architecture/`  
    - `visual/3d/materials/props/indoor/`  
    - `visual/3d/materials/props/outdoor/`  
    - `visual/3d/materials/props/terrain/`  
  - `visual/3d/materials/weapons/`

- `visual/3d/textures/`  
  Texture maps, also mirroring the models and materials structure:

  - `visual/3d/textures/creatures/`  
  - `visual/3d/textures/humanoids/`  
    - `visual/3d/textures/humanoids/player_female_01/`  
  - `visual/3d/textures/props/`  
    - `visual/3d/textures/props/architecture/`  
    - `visual/3d/textures/props/indoor/`  
    - `visual/3d/textures/props/outdoor/`  
    - `visual/3d/textures/props/terrain/`  
  - `visual/3d/textures/weapons/`

More detailed naming for assets (e.g. material and texture suffixes for albedo, normal, roughness) can be specified in a dedicated material and texture standard.

---

### 5.2 gui assets

Path:

- `visual/gui/`

Purpose:

- contain 2D and interface art for HUD and menus.

Subfolders:

- `visual/gui/hud/`  
  HUD art: crosshairs, health and armor bars, ammo icons, hit markers, objective markers, damage overlays, and similar on-screen game information.

- `visual/gui/menus/`  
  Menu art: background images, logo treatments, buttons, sliders, cursors, inventory icons, and settings icons.

Additional GUI categories (such as `visual/gui/icons/` or `visual/gui/dialogue/`) may be added if the project scope requires finer separation.

---

## 6. testing and sandbox content

Test and sandbox content should be clearly named and, when practical, grouped in dedicated subfolders to avoid confusion with production content.

Examples:

- `data/scenes/world/tests/` – experimental maps and prototype levels.  
- `data/scenes/player/tests/` – special scenes for testing player controller behavior.  
- `data/scripts/tests/` – temporary scripts used in experiments (if needed).

Test filenames should include `test` or `sandbox` to make intent clear.

---

## 7. coordination with other standards

This directory standard works together with:

- `data/documents/design/atlas_filename_standards.md`  
  Defines filename formats and patterns for code, documents, and reports.

- `data/documents/design/atlas_document_standards.md`  
  Defines structure, headers, revision history, and footers for Markdown documents.

- `data/documents/design/atlas_code_standards.md`  
  Defines required code file headers, footers, and changelog conventions.

These documents are intended to be maintained together and referenced from `qorders.md` at the repository root.

---

## revision_history

- **v0.1 — 2025-11-18**  
  - initial draft of directory standards for ATLAS, based on early project folder layout and collaboration requirements.

---

file: data/documents/design/atlas_directory_standards.md  
version: v0.1  
last_updated: 2025-11-18  
