# CLAUDE.md — 2D Pixel Art RPG (Godot)

## Project overview

A 2D pixel-art RPG built in Godot 4.x with GDScript. Developer is an experienced
software engineer (~12 years) but new to game development and Godot. Explain
Godot-specific idioms (scenes, nodes, signals, resources) when they come up;
don't explain general programming concepts.

**Scope guardrail:** target a 2–4 hour game maximum. When proposing features,
prefer cutting scope over adding it. Content (maps, quests, dialogue) is the
long pole — systems should stay simple and data-driven so content is cheap to add.

## Current milestone: Walking Skeleton (1–2 weeks)

A player character walking around one tilemap with collision, talking to one
NPC, and opening one chest. Nothing else until this works end to end.

Checklist:
- [x] Project setup with correct pixel-art settings (see below)
- [x] Player scene: sprite, movement (8-dir or 4-dir), collision
- [x] One test map using TileMapLayer with collision
- [ ] Camera following player, clamped to map bounds
- [x] Interaction system (Area2D + "interact" input action)
- [ ] One NPC with a simple dialogue box
- [ ] One chest that opens and gives an item (print to console is fine)

## Later milestones (do NOT start early)

1. Combat prototype — one enemy, one attack, HP, death
2. Inventory + stats
3. Save/load (JSON or Godot resources)
4. Content production — maps, quests, dialogue

## Tech decisions

- **Engine:** Godot 4.x (latest stable), GDScript
- **Editor:** VS Code with godot-tools extension; Godot editor for scenes/tilemaps
- **Art:** free asset packs for now (Kenney.nl, itch.io); Aseprite later if
  drawing custom art. 16×16 tile grid.
- **Resolution:** 320×180 base viewport, integer-scaled to window

## Pixel art project settings (Godot 4)

Apply these in Project Settings:
- `display/window/size/viewport_width = 320`, `viewport_height = 180`
- `display/window/size/window_width_override = 1280`, `window_height_override = 720`
- `display/window/stretch/mode = "viewport"`
- `display/window/stretch/aspect = "keep"`
- `display/window/stretch/scale_mode = "integer"`
- `rendering/textures/canvas_textures/default_texture_filter = "Nearest"`
  (disables texture filtering so pixels stay crisp)
- Snap 2D transforms/vertices to pixel: `rendering/2d/snap/snap_2d_transforms_to_pixel = true`

## Folder structure

```
res://
  scenes/          # .tscn files, one folder per feature
    player/
    npcs/
    maps/
    ui/
  scripts/         # shared/autoload scripts only; feature scripts live next to their scene
  assets/
    sprites/
    tilesets/
    audio/
    fonts/
  data/            # dialogue, items, quests as .tres resources or JSON
```

Convention: each gameplay feature is a self-contained scene (player.tscn +
player.gd side by side in scenes/player/).

## Code conventions

- GDScript with static typing everywhere (`var speed: float = 80.0`,
  typed function signatures)
- snake_case for files, functions, variables; PascalCase for classes/nodes
- Signals for decoupling (e.g. NPC emits `dialogue_requested`, UI listens);
  avoid reaching across the tree with `get_node("../../..")`
- Use `class_name` for reusable types
- Autoloads (singletons) only for: GameState, AudioManager, SceneTransition —
  keep the list short
- Input via named actions in the Input Map ("move_left", "interact"), never
  raw keycodes

## Working style

- Small, verifiable steps; after each change, state how to test it in-editor
- When a task involves editor-only steps (scene setup, tilemap painting),
  give exact click-path instructions since .tscn editing by hand is error-prone
  (though editing .tscn text directly is acceptable for simple changes)
- Run the game with F5 to verify; no formal test framework for now