# qorders – atlas collaboration brief

**project:** atlas  
**status:** draft  
**version:** v0.2  
**last_updated:** 2025-11-18  

---

## 1. scope and purpose

This document describes how work is organized and approached inside the ATLAS project.  
It serves as the primary entry point for collaborators and tools, and it summarizes:

- the overall goals and design pillars of ATLAS  
- how directories, filenames, and documents are structured  
- how code files are organized and annotated  
- where to find more detailed standards and guides  
- current high-level priorities

More detailed rules are defined in the dedicated standards documents under `data/documents/design/`.

---

## 2. project overview and design pillars

ATLAS is a third-person tactical shooter built in Godot 4.x.  
The project draws inspiration from classic shooters such as Quake and Half-Life in terms of level construction and pacing, while presenting gameplay from a modern third-person perspective.

Design pillars:

1. **grounded gunplay**  
   Weapons feel punchy and dangerous, with clear feedback and understandable behavior. Early implementations may use simplified hitscan but should be compatible with more advanced ballistic behavior later.

2. **modular characters and systems**  
   Characters, weapons, and world interactions are built from reusable components and shared systems rather than bespoke one-off logic.

3. **readable complexity**  
   Systems can be deep, but complexity is layered. Core flows (movement, aiming, shooting, interaction) should remain easy to understand from both design and code perspectives.

4. **in-engine level building**  
   Levels are assembled primarily inside Godot using modular props and architecture, minimizing heavy external level authoring that is difficult to iterate on.

5. **fast iteration and debugging**  
   In-game tools such as the console, debug HUD, and test scenes exist to support rapid experimentation and observation without being tightly coupled to game logic.

---

## 3. directory and filename standards (summary)

ATLAS uses a structured directory layout at the project root:

- `addons/` – Godot addons.  
- `audio/` – all audio assets.  
- `data/` – game data, scenes, scripts, and documents.  
- `visual/` – visual assets (3D, textures, GUI).

More detail is provided in:

- `data/documents/design/atlas_directory_standards.md`  
- `data/documents/design/atlas_filename_standards.md`  

Key conventions:

- filenames use **lowercase** with **underscores** (`snake_case`)  
- Godot scenes and scripts follow descriptive names, aligned where tightly coupled  
- documentation filenames avoid dates and version numbers in the filename itself  
- reports use an extended FQX-style pattern with dates and version suffixes

Example documentation filenames:

- `atlas_directory_standards.md`  
- `atlas_document_standards.md`  
- `atlas_code_standards.md`  
- `atlas_player_controller_guide.md`  

Example report filename:

- `2025-11-18_atlas-report_player_controller_initial_v01.md`

---

## 4. documentation standards (summary)

Human-readable documents for ATLAS are stored under:

- `data/documents/design/` – standards and guides  
- `data/documents/notes/` – exploratory notes  
- `data/documents/reports/` – session and context reports

Details are defined in:

- `data/documents/design/atlas_document_standards.md`

Shared rules:

- all documents use Markdown (`.md`)  
- each document begins with a header block including `project`, `status`, `version`, and `last_updated`  
- documents include a `revision_history` section near the end  
- documents end with a footer block identifying `file`, `version`, and `last_updated`

Reports are used to capture specific work sessions, refactors, investigations, and other contextual narratives.  
They follow the FQX-style filename convention and reference relevant code files and systems.

---

## 5. code standards (summary)

Code files live under:

- `data/scripts/`

Subfolders:

- `data/scripts/player/` – player logic, input, camera, movement.  
- `data/scripts/npc/` – NPC AI behaviors and state.  
- `data/scripts/props/` – interactive object logic.  
- `data/scripts/ui/` – HUD, menus, console and debug HUD logic.  
- `data/scripts/weapons/` – weapon mechanics and related systems.  
- `data/scripts/world/` – level scripting and world state.  
- `data/scripts/systems/` – global systems and utilities (autoloads, event bus, saving/loading, inventory, console backend, etc.).

Code file structure is defined in:

- `data/documents/design/atlas_code_standards.md`

Key rules:

- filenames use `snake_case`  
- each code file includes a **header** with file metadata, related documents, and a local changelog  
- each code file includes a **footer** confirming `end_of_file`, `version`, and `last_updated`  
- versioning is incremented for meaningful behavioral changes and documented in the header `changelog`

Larger changes that affect multiple files or systems should be documented in a report under `data/documents/reports/` and referenced from the `related_docs` field in relevant code file headers.

---

## 6. scenes and scripts

Scenes are stored under:

- `data/scenes/`

Subfolders:

- `data/scenes/player/` – player avatar roots and related scenes.  
- `data/scenes/npc/` – NPC root scenes for AI-controlled characters.  
- `data/scenes/props/` – props and interactive objects, including architectural pieces treated as props.  
- `data/scenes/ui/` – HUD, menus, overlays, console, debug HUD.  
- `data/scenes/weapons/` – weapon scenes and prefabs.  
- `data/scenes/world/` – level and world root scenes.
  - `data/scenes/world/tests/` – test and sandbox levels.

Scripts generally follow the same category structure under `data/scripts/` and use matching or closely related names where a one-to-one relationship exists between a scene and a script.

Test and experimental scenes should include `test` or `sandbox` in their filenames and be placed in `tests/` subfolders when appropriate.

More detail on directory usage is provided in:

- `data/documents/design/atlas_directory_standards.md`

---

## 7. visual and audio assets (high-level)

Visual assets are organized under:

- `visual/3d/` – 3D models, materials, textures, animations.  
- `visual/gui/` – HUD and menu art.

High-level structure:

- models: `visual/3d/models/{creatures,humanoids,props,weapons}/`  
- materials: `visual/3d/materials/...` mirroring models  
- textures: `visual/3d/textures/...` mirroring models  
- GUI HUD: `visual/gui/hud/`  
- GUI menus: `visual/gui/menus/`

Audio assets live under:

- `audio/`

With subfolders:

- `audio/ambient/` – ambient beds and loops.  
- `audio/bgm/` – music.  
- `audio/sfx/gear/` – equipment and gear sounds.  
- `audio/sfx/ui/` – interface sounds.  
- `audio/sfx/voice/` – voice lines and barks.  
- `audio/sfx/weapons/` – weapon sounds.  
- `audio/sfx/world/` – world and environment one-shots.

More detailed naming guidance for assets may be defined in future standards documents.

---

## 8. console and debug tooling

The in-game console and debug HUD are core tools for development and testing.

Console:

- implemented as a UI scene under `data/scenes/ui/`  
- UI scripts under `data/scripts/ui/`, backend under `data/scripts/systems/`  
- should fully capture input while open, with commands defined centrally

Debug HUD:

- implemented as a UI overlay in `data/scenes/ui/`  
- logic under `data/scripts/ui/`  
- may dock or position relative to the console while the console is open  
- displays selected runtime information (FPS, player state, weapon state, AI state) as needed

Debug tools should remain clearly separable from core gameplay logic to keep refactoring and build configuration straightforward.

---

## 9. version control and reports

Version control expectations:

- empty directories are tracked via `.gitkeep` files  
- Godot-generated cache and import directories remain excluded via `.gitignore`  
- commit messages briefly describe functional changes

Reports:

- stored in `data/documents/reports/`  
- use the FQX-style filename pattern: `YYYY-MM-DD_atlas-report_<slug>_vNN.md`  
- record the context, process, and outcomes of specific work sessions or refactors  
- are referenced from code file `related_docs` fields when appropriate

Reports and per-file changelogs complement each other: file headers capture local changes, while reports capture broader multi-file narratives.

---

## 10. current focus (example baseline)

This section provides a lightweight indication of project priorities.  
It should be updated as ATLAS evolves.

- **milestone 01 – core player loop**
  - third-person movement and camera.  
  - basic player avatar (e.g. `player_female_01` or a placeholder humanoid).  
  - simple weapon (hitscan pistol or rifle) with basic firing and ammo.  
  - test level blockout using modular props.

- **milestone 02 – baseline npc**
  - humanoid enemy with basic AI (patrol, detect, chase, shoot).  
  - shared humanoid animation set for movement and combat.  
  - simple encounter in a test level to validate combat flow.

- **milestone 03 – console and debugging**
  - functional in-game console with basic commands (help, quit, debugging toggles).  
  - debug HUD overlay showing key runtime data.  
  - clear separation between debug tooling and core game logic.

---

## 11. general guidance

- follow the directory and filename standards when adding or moving files  
- place assets, scenes, scripts, and documents in the most specific matching category  
- prefer reusable systems that support multiple weapons, NPC types, and levels  
- keep debug and development tools decoupled from core gameplay logic  
- use reports and revision histories to preserve reasoning behind significant decisions

For detailed rules and examples, refer to:

- `data/documents/design/atlas_directory_standards.md`  
- `data/documents/design/atlas_filename_standards.md`  
- `data/documents/design/atlas_document_standards.md`  
- `data/documents/design/atlas_code_standards.md`  

---

## revision_history

- **v0.1 — 2025-11-18**  
  - initial draft of QORDERS for ATLAS collaboration and project organization.

- **v0.2 — 2025-11-18**  
  - updated to reference `atlas_directory_standards.md`, `atlas_filename_standards.md`, `atlas_document_standards.md`, and `atlas_code_standards.md`.  
  - aligned terminology with finalized directory and filename conventions.  
  - clarified documentation, code header/footer, and report usage.  
  - added high-level summaries for audio, visual, and test content structure.

---

file: qorders.md  
version: v0.2  
last_updated: 2025-11-18  
