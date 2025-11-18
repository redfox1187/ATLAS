extends CanvasLayer

@onready var label: Label = $label
var player: Node = null

# Padding for the HUD relative to screen edges and console
@export var left_padding: float = 10.0
@export var top_padding: float = 10.0

# We’ll locate the console panel by group 'console_panel'
var console_panel: Panel = null
const PANEL_FALLBACK_HEIGHT: float = 220.0  # used if panel height not set

func _ready() -> void:
	# find the player by group
	player = get_tree().get_first_node_in_group("player")
	if player == null:
		push_warning("DebugHUD: no node in group 'player' found.")

	# find the console panel by group
	var n: Node = get_tree().get_first_node_in_group("console_panel")
	if n and n is Panel:
		console_panel = n as Panel
	else:
		push_warning("DebugHUD: no Panel in group 'console_panel' found. HUD will stay at top.")

	# Make sure the label is top-left anchored so position works as expected
	if label is Control:
		var c := label as Control
		c.anchor_left = 0.0
		c.anchor_top = 0.0
		c.anchor_right = 0.0
		c.anchor_bottom = 0.0

func _process(_dt: float) -> void:
	# --- Follow the console panel ---
	if console_panel:
		var h: float = console_panel.custom_minimum_size.y
		if h <= 0.0:
			h = PANEL_FALLBACK_HEIGHT
		# When hidden: panel.position.y = -h -> y = 0 (top). When open: 0 -> y = h.
		var y_below_console: float = max(0.0, console_panel.position.y + h)
		label.position = Vector2(left_padding, y_below_console + top_padding)
	else:
		# Stay pinned to top-left if no console panel
		label.position = Vector2(left_padding, top_padding)

	# --- Build the debug text (unchanged from before) ---
	if player == null:
		return

	var ads: bool = false
	var crouch: bool = false
	var crouch_toggle: bool = false
	var sprinting: bool = false
	var v: Vector3 = Vector3.ZERO
	var on_floor: bool = false
	var invert_y: bool = false
	var mouse_locked: bool = false

	if "get_debug_state" in player:
		var st: Dictionary = player.get_debug_state()
		ads = st.get("is_ads", false)
		crouch = st.get("is_crouching", false)
		crouch_toggle = st.get("crouch_toggle", false)
		sprinting = st.get("sprinting", false)
		v = st.get("velocity", Vector3.ZERO)
		on_floor = st.get("on_floor", false)
		invert_y = st.get("invert_y", false)
		mouse_locked = st.get("mouse_locked", false)
	else:
		if "velocity" in player: v = player.velocity
		if "is_on_floor" in player: on_floor = player.is_on_floor()
		if "_is_ads" in player: ads = player._is_ads
		if "_is_crouching" in player: crouch = player._is_crouching

	var ui_capturing: bool = false
	if "ui_capturing" in InputRouter:
		ui_capturing = InputRouter.ui_capturing

	label.text = "DEBUG\n" \
		+ "- ADS: %s\n" % ("ON" if ads else "OFF") \
		+ "- Crouch: %s (toggle=%s)\n" % [("ON" if crouch else "OFF"), ("ON" if crouch_toggle else "OFF")] \
		+ "- Sprinting: %s\n" % ("YES" if sprinting else "NO") \
		+ "- Vel: (%.2f, %.2f, %.2f)\n" % [v.x, v.y, v.z] \
		+ "- On Floor: %s\n" % ("YES" if on_floor else "NO") \
		+ "- Invert Y: %s\n" % ("TRUE" if invert_y else "FALSE") \
		+ "- Mouse Locked: %s\n" % ("TRUE" if mouse_locked else "FALSE") \
		+ "- UI Capturing: %s" % ("TRUE" if ui_capturing else "FALSE")
