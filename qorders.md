# QORDERS – ATLAS Collaboration Brief

## 1. Project Overview

ATLAS is a third-person tactical shooter built in Godot 4.x.  
The project focuses on grounded gunplay, modular characters (players and NPCs), and reusable systems for weapons, levels, and AI.

ATLAS draws inspiration from classic shooters such as Quake and Half-Life in terms of level construction and moment-to-moment feel, while targeting a more modern third-person presentation.

---

## 2. Design Pillars

The following principles should guide design and implementation decisions:

1. **Grounded gunplay**  
   Weapons should feel punchy and dangerous, with readable recoil, clear feedback, and understandable behavior. Implementation may begin with simplified hitscan but should be compatible with more advanced ballistic behavior.

2. **Modular characters and systems**  
   Characters, weapons, and world interactions should be built from reusable components rather than bespoke one-off logic. Shared systems should be preferred over per-entity special cases.

3. **Readable complexity**  
   Systems may be deep, but complexity should be layered. Core flows (movement, aiming, shooting, taking cover) must remain understandable from both design and code perspectives.

4. **In-engine level building**  
   Levels should be composed primarily from modular props and architecture directly in Godot, minimizing “build externally, then shoehorn it in” workflows. External tools may be used for assets, but level assembly is expected to happen in `data/scenes/world/`.

5. **Fast iteration and debugging**  
   The in-game console, debug HUD, and test scenes exist to support rapid experimentation. Tooling should expose useful information without becoming tightly coupled to game logic.

---

## 3. Directory and Asset Standards

All paths, examples, and file suggestions must follow the project directory standards defined in:

- `data/documents/design/ATLAS_Directory_Standards.md`  

Key principles:

- Code and scenes are stored under `data/`.
- Visual assets are stored under `visual/`.
- Audio assets are stored under `audio/`.
- `npc` denotes a gameplay role (non-player characters controlled by AI).
- `humanoids` and `creatures` are art taxonomy categories based on rig/skeleton type:
  - `humanoids` share a humanoid rig.
  - `creatures` represent non-humanoid rigs (animals, aliens, monsters, etc.).

When introducing new folders or categories, extensions of the existing patterns are preferred over ad-hoc structures.

---

## 4. Code Conventions (High-Level)

- Scripts associated with a specific scene should use matching names where practical.  
  Example:  
  - `data/scenes/npc/humanoid_soldier_01.tscn`  
  - `data/scripts/npc/humanoid_soldier_01.gd`

- Shared systems and utilities are placed in `data/scripts/systems/`.

- Default language for examples is Godot 4.x GDScript.

- Systems should be designed as small, focused, and composable rather than large monolithic scripts.

- Node and scene structure should follow the `data/scenes/*` layout where possible:
  - Scene roots in `data/scenes/...`
  - Logic in `data/scripts/...`
  - Visuals in `visual/...`

- When proposing new code, examples should:
  - Use Godot 4.x idioms (signals, typed GDScript, etc.).
  - Avoid reliance on deprecated patterns from older Godot versions.

---

## 5. Scene and Asset Roles

### 5.1 Scenes

Scene categories:

- `data/scenes/player/`  
  Player avatar roots, controllers, and related player-specific scenes.

- `data/scenes/npc/`  
  NPC roots for AI-controlled characters (humanoid or creature).

- `data/scenes/props/`  
  Props and interactive objects, including doors, terminals, turrets, destructibles, and architectural pieces treated as props.

- `data/scenes/ui/`  
  HUD elements, menus, overlays, console, debug HUD, and other UI widgets.

- `data/scenes/weapons/`  
  Weapons, weapon rigs, and weapon-related prefabs.

- `data/scenes/world/`  
  World and level root scenes, constructed primarily by instancing props, characters, and other scenes.

Test or sandbox scenes should be clearly named (e.g., `test_*` or `sandbox_*`) and can reside within the appropriate category, or under a dedicated `tests/` subfolder inside that category when needed.

### 5.2 Scripts

Script categories mirror scenes and systems:

- `data/scripts/player/` – player logic, input, camera, movement.  
- `data/scripts/npc/` – AI behaviors, state machines, NPC logic.  
- `data/scripts/props/` – scripts for props, including interactive and environmental objects.  
- `data/scripts/ui/` – HUD, menus, console UI, debug HUD logic.  
- `data/scripts/weapons/` – weapon mechanics and related systems.  
- `data/scripts/world/` – world and mission logic tied to levels.  
- `data/scripts/systems/` – global systems, managers, and utilities (autoloads, event bus, inventory, saving/loading, console backend, etc.).

Scripts not tied to any specific scene should be placed under `data/scripts/systems/` or in a functional category that best matches their purpose.

### 5.3 Visual Assets

Visual assets are placed under `visual/`:

- `visual/3d/models/`  
  - `creatures/` – non-humanoid rigs.  
  - `humanoids/` – humanoid rigs (e.g., `player_female_01`, `player_female_02`, `player_male_01`).  
  - `props/` – with suggested subfolders:
    - `architecture/` – structural pieces (walls, buildings, corridors).  
    - `indoor/` – interior props and clutter.  
    - `outdoor/` – exterior props and street clutter.  
    - `terrain/` – terrain pieces, rocks, natural features.  
  - `weapons/` – weapon meshes and attachments.

- `visual/3d/materials/`  
  Mirrors the `models/` structure: `creatures/`, `humanoids/`, `props/architecture`, `props/indoor`, `props/outdoor`, `props/terrain`, and `weapons/`.

- `visual/3d/textures/`  
  Mirrors the `models/` and `materials/` structure.

- `visual/gui/hud/`  
  HUD-specific art: crosshairs, health bars, ammo icons, hit markers, objective markers, HUD overlays.

- `visual/gui/menus/`  
  Menu art: backgrounds, buttons, cursors, inventory icons, settings icons, and general menu elements.

---

## 6. Documentation and Output

- Design documents, specifications, and standards are stored under:  
  `data/documents/design/`

- Short notes, scratch text, and brainstorm material are stored under:  
  `data/documents/notes/`

- New documentation generated for ATLAS should:
  - Use Markdown format.
  - Include a suggested path under `data/documents/design/` or `data/documents/notes/` as appropriate.
  - Reference related files and systems using project-relative paths.

When documenting systems, the preferred structure is:

1. Purpose and scope.  
2. Responsibilities and boundaries.  
3. Key nodes/scenes/scripts involved (with paths).  
4. Extension points and known limitations.

---

## 7. Character and Model Taxonomy

### 7.1 Roles

- **Player** – Playable avatars.  
- **NPC** – Non-player characters controlled by AI, including humanoids, creatures, robots, mechs, and similar entities.

### 7.2 Visual Categories

- **Humanoids**  
  Entities with humanoid skeletons capable of sharing a common humanoid animation set.

- **Creatures**  
  Entities that do not share a humanoid skeleton, regardless of whether they are animals, aliens, or abstract monsters.  
  Classification is decided by rig compatibility, not by lore or narrative role.

### 7.3 Naming Patterns

- Player avatars (visual side):  
  - `player_female_01`, `player_female_02`, `player_male_01`, etc.  
  These represent base body types; customization is handled via attached models (hair, armor, gear, accessories).

- Generic humanoids:  
  - `humanoid_soldier_01`, `humanoid_soldier_02_heavy`, `humanoid_soldier_03_sniper`, etc.

- Creatures:  
  - `creature_dog_01`, `creature_cat_01`, `creature_alien_bug_01`, etc.

Scene and script names should align with visual asset names where a one-to-one relationship exists.

---

## 8. World and Level Building

- World and level root scenes are stored in `data/scenes/world/`.  
- Levels are constructed by instancing props, NPCs, players, and other scenes.

Guidelines:

- Architectural elements and building shells:  
  - Models under `visual/3d/models/props/architecture/`  
  - Materials and textures under matching `props/architecture/` folders.

- Interior props:  
  - `visual/3d/models/props/indoor/` and corresponding materials/textures.

- Exterior props:  
  - `visual/3d/models/props/outdoor/` and corresponding materials/textures.

- Terrain and natural features:  
  - `visual/3d/models/props/terrain/` and corresponding materials/textures.

World scripts (mission flow, triggers, world states) reside in `data/scripts/world/`.

Test and experimental levels should be clearly named and can be isolated in subfolders (e.g., `data/scenes/world/tests/`) to distinguish them from production content.

---

## 9. Console and Debug Tooling

The in-game console and debug HUD are considered core tools for development and testing.

### 9.1 Console

- The console is a UI element and should be implemented as a scene under `data/scenes/ui/` with associated logic under `data/scripts/ui/` and/or `data/scripts/systems/`.
- The console must:
  - Fully capture keyboard input while open, preventing unintended player actions.
  - Provide a clear, scrollable log area and an input field.
  - Support a set of core commands (e.g., help, quit/exit, map/test commands, debug toggles).

- Console backend and command registration should be handled in a central system script (e.g., under `data/scripts/systems/`), avoiding tight coupling of game logic directly inside the UI layer.

### 9.2 Debug HUD

- The debug HUD is treated as a UI overlay, residing under `data/scenes/ui/` with logic under `data/scripts/ui/`.
- Debug HUD behavior:
  - Can be docked or positioned relative to the console when the console is open.
  - Displays key runtime information (FPS, player state, weapon state, AI state, etc.) as needed.
  - Should be easy to enable/disable via console commands or debug keys.

- Debug-only UI elements should be clearly marked in code and easy to strip or disable for production builds.

---

## 10. Version Control Practices

- Empty directories are not tracked by Git by default. To ensure important structural folders exist in the repository, placeholder files such as `.gitkeep` may be used.

- Generated or cache directories from Godot (e.g., `.import/`, `.godot/`, `.export/`) must remain excluded via `.gitignore`.

- Large binary assets should be added thoughtfully. If a directory is intended to stay present even when empty, a `.gitkeep` file is preferred over leaving the directory untracked.

- Commit messages should briefly state the functional change or purpose (e.g., `Add basic player controller`, `Implement console help command`, `Organize props/architecture models`).

---

## 11. Current Focus (Editable Checklist)

This section is intended as a lightweight guide to current priorities and may be updated frequently.

Example baseline:

- **Milestone 01 – Core Player Loop**
  - Third-person movement and camera.
  - Basic player avatar using `player_female_01` or a placeholder humanoid.
  - Simple weapon (e.g., hitscan pistol or rifle) with basic firing and ammo.
  - Test level blockout using modular props under `visual/3d/models/props/`.

- **Milestone 02 – Baseline NPC**
  - Humanoid enemy with basic AI (patrol, detect, chase, shoot).
  - Shared humanoid animation set for movement and combat.
  - Simple encounter in a test level to validate combat flow.

- **Milestone 03 – Console and Debugging**
  - Functional in-game console with basic commands (help, quit, simple debugging utilities).
  - Debug HUD overlay showing key runtime data.
  - Clear separation between debug tooling and core game logic.

---

## 12. General Guidance

- Maintain consistency with the directory and naming standards.  
- Place assets, scenes, and scripts in the most specific matching category, using the existing folder structure.  
- Prefer reusable solutions that support multiple weapons, NPC types, and levels.  
- When proposing new structures or systems, align with the separation between:
  - `data/` for logic and scenes,  
  - `visual/` for art,  
  - `audio/` for sound,  
  - `data/documents/` for design and notes.

- Debug and development tools should support experimentation without becoming tightly bound to game systems, to keep refactoring and iteration straightforward.

