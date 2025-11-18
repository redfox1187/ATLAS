extends CanvasLayer

@onready var panel: Panel = get_node_or_null("Panel") as Panel
@onready var log_label: RichTextLabel = get_node_or_null("Panel/VBoxContainer/Log") as RichTextLabel
@onready var input_line: LineEdit = get_node_or_null("Panel/VBoxContainer/Input") as LineEdit

var is_open: bool = false
var commands: Dictionary = {}   # cmd -> { "call": Callable, "help": String }
var max_lines: int = 200

func _ready() -> void:
	if panel == null:
		push_warning("console.gd: Panel not found at 'Panel'."); return
	if log_label == null:
		push_warning("console.gd: Log not found at 'Panel/VBoxContainer/Log'."); return
	if input_line == null:
		push_warning("console.gd: Input not found at 'Panel/VBoxContainer/Input'."); return

	# LineEdit must be focusable/editable
	input_line.focus_mode = Control.FOCUS_ALL
	input_line.editable = true

	_register_builtin_commands()

	if input_line.text_submitted.is_connected(_on_submit):
		input_line.text_submitted.disconnect(_on_submit)
	input_line.text_submitted.connect(_on_submit)

	hide_console_immediate()
	visible = true

func _input(event: InputEvent) -> void:
	# Toggle key only
	if event.is_action_pressed("toggle_console"):
		toggle_console()
		get_viewport().set_input_as_handled()
		return

	# Do NOT swallow all keys—let the LineEdit get them.
	# Only provide a fallback submit on Enter if needed.
	if is_open and event is InputEventKey and event.pressed and not event.echo:
		var k: InputEventKey = event
		if (k.keycode == KEY_ENTER or k.keycode == KEY_KP_ENTER) and input_line != null and input_line.has_focus():
			_on_submit(input_line.text)
			get_viewport().set_input_as_handled()

func toggle_console() -> void:
	is_open = not is_open
	InputRouter.ui_capturing = is_open
	if is_open:
		_show_console()
	else:
		_hide_console()

func _show_console() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if input_line != null:
		input_line.editable = true
	call_deferred("_focus_input")
	var tw: Tween = create_tween()
	tw.tween_property(panel, "position:y", 0.0, 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func _focus_input() -> void:
	if input_line != null:
		input_line.grab_focus()
		input_line.caret_column = input_line.text.length()

func _hide_console() -> void:
	if input_line != null:
		input_line.release_focus()
		input_line.editable = false
	var tw: Tween = create_tween()
	tw.tween_property(panel, "position:y", -220.0, 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tw.finished.connect(func() -> void:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED))

func hide_console_immediate() -> void:
	panel.set_deferred("position", Vector2(panel.position.x, -220.0))
	panel.set_deferred("custom_minimum_size", Vector2(panel.custom_minimum_size.x, 220.0))

func _on_submit(text: String) -> void:
	var t: String = text.strip_edges()
	if t == "":
		return
	_log_line("[b]>[/b] " + t)
	_run_command(t)
	if input_line != null:
		input_line.clear()

func _run_command(text: String) -> void:
	var parts: Array = text.strip_edges().split(" ", false, 0)
	if parts.is_empty():
		return
	var cmd_name: String = String(parts[0]).to_lower()
	var args: Array = parts.slice(1, parts.size()) if parts.size() > 1 else []
	if commands.has(cmd_name):
		var entry: Dictionary = commands[cmd_name]
		var c: Callable = entry["call"]
		var out: Variant = c.call(args)
		_log_line(str(out))
	else:
		_log_line("[color=orangered]Unknown command:[/color] " + cmd_name)

func _log_line(s: String) -> void:
	log_label.append_text(s + "\n")  # Godot 4
	if log_label.get_paragraph_count() > max_lines:
		log_label.clear()
		log_label.append_text("[i]-- log cleared --[/i]\n")

func register_command(cmd_name: String, c: Callable, help: String = "") -> void:
	commands[cmd_name.to_lower()] = { "call": c, "help": help }

# ---------- Quit helpers ----------
func _cmd_quit(_args: Array) -> String:
	call_deferred("_do_quit")
	return "Quitting..."

func _do_quit() -> void:
	get_tree().quit()

# -------------------------
# Built-in commands
# -------------------------
func _register_builtin_commands() -> void:
	register_command("help", func(_args: Array) -> String:
		var keys: Array = commands.keys(); keys.sort()
		return "[b]Commands:[/b] " + ", ".join(keys) + "\nType: help <name>"
	, "List commands.")

	register_command("quit", func(args: Array) -> String:
		return _cmd_quit(args)
	, "Close the game.")
	register_command("exit", func(args: Array) -> String:
		return _cmd_quit(args)
	, "Close the game.")
	register_command("qqq", func(args: Array) -> String:
		return _cmd_quit(args)
	, "Close the game.")

	register_command("echo", func(args: Array) -> String:
		return " ".join(args)
	, "Echo text.")

	register_command("pos", func(_args: Array) -> String:
		var p: Node = _get_player()
		return "Player pos: " + str(p.global_position) if p != null else "Player not found."
	, "Print player position.")

	register_command("tp", func(args: Array) -> String:
		if args.size() < 3:
			return "Usage: tp <x> <y> <z>"
		var p: Node = _get_player()
		if p == null:
			return "Player not found."
		var x: float = float(args[0]); var y: float = float(args[1]); var z: float = float(args[2])
		p.global_position = Vector3(x, y, z)
		return "Teleported."
	, "Teleport player.")

	register_command("fov", func(args: Array) -> String:
		if args.size() != 1:
			return "Usage: fov <number>"
		var p: Node = _get_player(); if p == null: return "Player not found."
		var v: float = clamp(float(args[0]), 40.0, 110.0)
		if p.has_node("Pivot/ADSCam"):
			(p.get_node("Pivot/ADSCam") as Camera3D).fov = v
		if p.has_node("Pivot/SpringArm3D/ThirdPersonCam"):
			(p.get_node("Pivot/SpringArm3D/ThirdPersonCam") as Camera3D).fov = v
		return "FOV set to %s" % v
	, "Set TPS/ADS FOV.")

	register_command("invert_y", func(args: Array) -> String:
		if args.size() != 1:
			return "Usage: invert_y <true|false>"
		var p: Node = _get_player(); if p == null: return "Player not found."
		var val: bool = (String(args[0]).to_lower() == "true")
		if "invert_y" in p:
			p.invert_y = val
			return "invert_y = %s" % val
		return "Player has no 'invert_y'."
	, "Toggle mouse Y invert.")

func _get_player() -> Node:
	return get_tree().get_first_node_in_group("player")
