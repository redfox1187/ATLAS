# ATLAS Project Directory Standards

**Version:** 0.1  
**Project:** ATLAS (Godot)

This document defines the directory structure for the ATLAS project and specifies what belongs where.  
The goals are:

- Clear separation of code, data, audio, and visual assets.  
- Predictable locations for all content types.  
- Support for reuse of humanoid and non-humanoid assets.  
- Minimal pre-planning while leaving room for future expansion.

---

## 1. Top-Level Layout

Project root uses the following top-level directories:

- `addons/` – Godot plugins and editor extensions.  
- `audio/` – All sound content.  
- `data/` – Game scenes, scripts, human-readable project documents, and (eventually) configuration data.  
- `visual/` – Visual assets only (3D, GUI, shaders, VFX, etc.).

No gameplay assets, scripts, or scenes should be placed directly in the project root.

---

## 2. `addons/`

**Purpose:**  
Godot addons and editor plugins.

**Contents:**

- Third-party addons.  
- Custom editor tools implemented as Godot addons.

**Rules:**

- Gameplay scripts that are not part of an addon must not be placed here.  
- Addons should be self-contained within their own subfolders.

---

## 3. `audio/`

**Purpose:**  
All sound assets used by the game.

**Structure:**

- `audio/ambient/`  
  Environmental loops and ambience (wind, rain, room tone, city noise, etc.).

- `audio/bgm/`  
  Background music, combat music, stingers, and themes.

- `audio/sfx/`  
  Gameplay sound effects, organized by function:
  - `audio/sfx/gear/` – Armor rustle, equipment handling, footsteps, holsters.  
  - `audio/sfx/ui/` – Menu sounds, HUD beeps, confirmations, errors.  
  - `audio/sfx/voice/` – Voice lines, barks, shouts, callouts.  
  - `audio/sfx/weapons/` – Gunshots, reloads, dry fires, impacts, etc.  
  - `audio/sfx/world/` – Doors, switches, debris, environment interactions, physics sounds.

**Classification guidelines:**

- Sounds attached to physical objects or actions → place under `gear/`, `weapons/`, or `world/`.  
- UX and menu-related sounds → place under `ui/`.  
- Spoken dialogue, shouts, and barks → place under `voice/`.

---

## 4. `data/`

`data/` contains all game scenes, scripts, and project documents. It may later include machine-readable configuration files.

### 4.1 `data/documents/`

**Purpose:**  
Human-readable documents only. Not intended for runtime consumption.

**Recommended structure:**

- `data/documents/design/` – Design documents, feature specifications, narrative overviews.  
- `data/documents/notes/` – Ad-hoc notes, scratchpads, to-do lists, brainstorming text.

**Rules:**

- Machine-readable configuration data (JSON, CSV, `.tres`, etc.) should not be placed here.  
- Documents should not be loaded directly by the game at runtime.

---

### 4.2 `data/scenes/`

**Purpose:**  
All Godot scenes (`.tscn`) used in the game.

**Structure:**

- `data/scenes/npc/`  
  Scenes for non-player characters (NPCs), including creatures, humanoids, robots, etc., controlled by AI.

- `data/scenes/player/`  
  Scenes for player avatars, player rigs, and player-specific controllers.

- `data/scenes/props/`  
  Scenes for props: interactable or static objects such as doors, crates, terminals, furniture, and architectural pieces treated as props.

- `data/scenes/ui/`  
  Scenes for HUD elements, menus, overlays, and UI widgets.

- `data/scenes/weapons/`  
  Scenes for weapons, weapon rigs, attachments, and related interactive elements.

- `data/scenes/world/`  
  World/level roots and large-scale world assemblies built primarily by instancing props and other scenes.

**Rules:**

- Each in-game entity should have a primary scene under one of these subfolders.  
- Scenes should not be mixed across categories (e.g., weapon scenes should not be placed in `world/`).

---

### 4.3 `data/scripts/`

**Purpose:**  
Game code, including scripts attached to scenes and scripts that represent shared systems or modules.

**Structure:**

- `data/scripts/npc/`  
  Scripts for NPC logic, AI behaviors, state machines, and NPC-specific functionality.

- `data/scripts/player/`  
  Scripts for player control, input handling, camera logic, and player-specific systems.

- `data/scripts/props/`  
  Scripts for props (doors, switches, turrets, destructible objects, terminals, etc.).

- `data/scripts/systems/`  
  Global or shared systems and services, such as:
  - Autoload singletons (event bus, inventory system, save/load, console, etc.).  
  - Game-wide managers and utilities.  
  - Code modules that are not tied to a single scene but provide reusable functionality.

- `data/scripts/ui/`  
  Scripts for menus, HUD logic, notifications, and UI interaction handling.

- `data/scripts/weapons/`  
  Weapon logic (firing, recoil, ammo management, weapon sway, aiming models, etc.).

- `data/scripts/world/`  
  Scripts for level logic, world triggers, mission flow, and world-specific systems.

**Rules:**

- Scripts that are clearly associated with a specific scene category should reside in the matching subfolder.  
- Scripts that are not tied to any particular scene (e.g., general utilities or systems) should be placed in `data/scripts/systems/` or in the most appropriate functional category.  
- Script names should closely mirror related scene or model names where there is a tight coupling (e.g., `humanoid_soldier_01.tscn` → `humanoid_soldier_01.gd`).

---

### 4.4 (Reserved) `data/config/`

**Purpose:**  
Machine-readable configuration data for the game (future use).

**Examples:**

- `data/config/weapon_stats.json`  
- `data/config/enemy_spawn_profiles.csv`  
- `data/config/difficulty_profiles.tres`

**Rules:**

- Intended for structured data loaded by scripts at runtime.  
- Not intended for human design notes or narrative text.

---

## 5. `visual/`

`visual/` contains only visual assets: models, textures, materials, animations, GUI art, and (later) shaders and VFX. No scripts or scenes should be placed here.

### 5.1 `visual/3d/`

**Purpose:**  
All 3D content, organized by asset type and function.

#### 5.1.1 `visual/3d/animations/`

- `visual/3d/animations/humanoids/`  
  Shared humanoid animation sets (walk, run, idle, reload, aim, etc.).

Additional subfolders may be introduced as needed (`creatures/`, `weapons/`, etc.) following the same naming patterns used elsewhere.

---

#### 5.1.2 `visual/3d/models/`

3D model files organized by category.

- `visual/3d/models/creatures/`  
  Models for non-humanoid entities (dogs, cats, aliens, fish, bugs, monsters, etc.).  
  Classification is based on rig type rather than lore; anything that does not share a humanoid skeleton belongs here.

- `visual/3d/models/humanoids/`  
  Models for humanoid entities that share a broadly compatible humanoid rig.
  - `visual/3d/models/humanoids/player_female_01/`  
	Models for a specific player avatar body type (e.g., `player_female_01`).  
	Additional player options follow the same pattern (e.g., `player_female_02`, `player_male_01`).

- `visual/3d/models/props/`  
  Models for props and structural pieces. Suggested substructure:

  - `visual/3d/models/props/architecture/`  
	Structural elements such as walls, pillars, building shells, modular corridor pieces, windows, doors used as part of architectural shells, etc.

  - `visual/3d/models/props/indoor/`  
	Interior props: furniture, terminals, decorative objects, small indoor clutter.

  - `visual/3d/models/props/outdoor/`  
	Exterior props: street furniture, vehicles, fences, lampposts, exterior signage, outdoor clutter.

  - `visual/3d/models/props/terrain/`  
	Terrain pieces: cliffs, rocks, ground chunks, modular terrain tiles, natural formations.

- `visual/3d/models/weapons/`  
  Weapon models and related attachments (barrels, scopes, magazines, etc.).

---

#### 5.1.3 `visual/3d/materials/`

Materials for 3D assets, mirroring the structure used in `models/`.

- `visual/3d/materials/creatures/`  
- `visual/3d/materials/humanoids/`  
  - `visual/3d/materials/humanoids/player_female_01/`  
- `visual/3d/materials/props/`  
  - `visual/3d/materials/props/architecture/`  
  - `visual/3d/materials/props/indoor/`  
  - `visual/3d/materials/props/outdoor/`  
  - `visual/3d/materials/props/terrain/`  
- `visual/3d/materials/weapons/`

**Rule:**  
For ease of lookup, materials should be placed under the matching subfolder used for their associated models.

---

#### 5.1.4 `visual/3d/textures/`

Textures for 3D assets, also mirroring the `models/` structure.

- `visual/3d/textures/creatures/`  
- `visual/3d/textures/humanoids/`  
  - `visual/3d/textures/humanoids/player_female_01/`  
- `visual/3d/textures/props/`  
  - `visual/3d/textures/props/architecture/`  
  - `visual/3d/textures/props/indoor/`  
  - `visual/3d/textures/props/outdoor/`  
  - `visual/3d/textures/props/terrain/`  
- `visual/3d/textures/weapons/`

**Rule:**  
Textures should follow the same categorization as the models they are used on.

---

### 5.2 `visual/gui/`

**Purpose:**  
All 2D art used for HUD and menus.

**Structure:**

- `visual/gui/hud/`  
  Crosshairs, health bars, ammo icons, objective markers, hit indicators, HUD overlays, and other in-game HUD art.

- `visual/gui/menus/`  
  Menu backgrounds, button sprites, cursors, inventory icons, settings icons, and other menu-related visual elements.

**Rules:**

- Any 2D visual element that appears as part of the user interface should be placed here.  
- HUD-specific art belongs under `hud/`; general or menu art belongs under `menus/`.

---

### 5.3 (Reserved) `visual/shaders/`

**Purpose:**  
Custom shader files and shader graphs (future use).

**Examples:**

- Surface shaders for stylized materials.  
- Post-processing shaders.  
- Special effect shaders (distortion, holograms, etc.).

---

### 5.4 (Reserved) `visual/vfx/`

**Purpose:**  
Visual effects assets and prefabs (future use).

**Examples:**

- Particle textures and flipbooks.  
- Scene templates for muzzle flashes, explosions, smoke, and energy effects.  
- Combined VFX setups referencing multiple textures, materials, and shaders.

---

## 6. Character and Model Taxonomy

### 6.1 Roles

- **Player:** Playable avatars.  
- **NPC:** Any non-player character controlled by AI, including humanoids, creatures, robots, mechs, and similar entities.

### 6.2 Visual Categories

- **Humanoids:**  
  Entities with humanoid skeletons capable of sharing common humanoid animation sets.

- **Creatures:**  
  Entities that do not share a humanoid skeleton, regardless of whether they are animals, aliens, or abstract monsters.  
  The classification is driven by rig compatibility, not narrative or lore.

### 6.3 Naming Patterns

**Player avatars (visual side):**

- `player_female_01`, `player_female_02`, `player_male_01`, etc.  
  These represent base body types. Additional customization (hair, gear, accessories) is handled via attached models and configuration.

**Generic humanoids:**

- `humanoid_soldier_01`, `humanoid_soldier_02_heavy`, `humanoid_soldier_03_sniper`, etc.  
  Same or similar rigs, different gear and visual loadouts.

**Creatures:**

- `creature_dog_01`, `creature_cat_01`, `creature_alien_bug_01`, etc.

**Scenes and scripts:**

- Scene and script names should align with visual asset names when there is a one-to-one relationship:  
  - `data/scenes/npc/humanoid_soldier_01.tscn`  
  - `data/scripts/npc/humanoid_soldier_01.gd`  
  - `visual/3d/models/humanoids/humanoid_soldier_01/…`

---

## 7. World and Level Building

Worlds and levels are constructed primarily in Godot, using props and other scenes.

**Standards:**

- World roots:  
  - `data/scenes/world/mission01_city_block.tscn`  
  - `data/scenes/world/mission02_outskirts.tscn`, etc.

- World scripts:  
  - `data/scripts/world/mission01_city_block.gd`, etc.

- Building geometry and large structural elements (walls, building shells, modular corridors) are treated as props and placed under:
  - `visual/3d/models/props/architecture/`  
  with materials and textures in the corresponding `props/architecture/` folders.

- Smaller interior and exterior details are placed under:
  - `visual/3d/models/props/indoor/` and `visual/3d/models/props/outdoor/`.

- Terrain and natural features belong in:
  - `visual/3d/models/props/terrain/`.

Levels are assembled by instancing props, characters, and other scenes into world root scenes.

---

## 8. Documents vs Configuration Data

**Human-readable project documents:**

- Stored under `data/documents/` (with suggested subfolders `design/` and `notes/`).  
- Not intended for runtime loading.

**Machine-readable configuration data (future):**

- Stored under `data/config/`.  
- Used for game balancing, data tables, and structured settings consumed by scripts.

---

## 9. Asset Placement Summary

When creating new assets, apply the following guidelines:

- **New sound:**  
  Place in `audio/`, using the relevant subfolder (`ambient`, `bgm`, or under `sfx/*`).

- **New scene:**  
  Place in `data/scenes/` under the category matching its role (`npc`, `player`, `props`, `ui`, `weapons`, `world`).

- **New script:**  
  Place in `data/scripts/` under the matching functional category.  
  If the script provides a shared system or is not tied to a specific scene, place it in `data/scripts/systems/`.

- **New 3D model:**  
  Place in `visual/3d/models/` under `creatures/`, `humanoids/`, `props/` (and subfolders), or `weapons/`.

- **New 3D material or texture:**  
  Place in the corresponding `visual/3d/materials/…` or `visual/3d/textures/…` folder that matches the model category and subcategory.

- **New UI art:**  
  Place HUD art in `visual/gui/hud/`.  
  Place menu art and general UI icons in `visual/gui/menus/`.

---

This document is intended as a living reference. As the ATLAS project grows, additional subfolders and conventions may be introduced, but they should follow the patterns established here whenever possible.
