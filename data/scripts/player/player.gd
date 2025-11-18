extends CharacterBody3D

# -----------------
# Tunables
# -----------------
@export var walk_speed: float = 5.0
@export var sprint_mult: float = 1.6
@export var crouch_mult: float = 0.6
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.12
@export var invert_y: bool = false	# set true for “pull mouse down to look up”

var gravity: float = 9.8

# -----------------
# Node refs
# -----------------
@onready var pivot: Node3D = $Pivot
@onready var tps_cam: Camera3D = $Pivot/SpringArm3D/ThirdPersonCam
@onready var ads_cam: Camera3D = $Pivot/ADSCam
@onready var fire_origin: Marker3D = $FireOrigin

# -----------------
# State
# -----------------
var _mouse_locked: bool = true
var _is_ads: bool = false
var _is_crouching: bool = false
var _crouch_toggle_state: bool = false	# toggled by the 'crouch_toggle' action

var _yaw: float = 0.0
var _pitch: float = 0.0

func _ready() -> void:
	gravity = float(ProjectSettings.get_setting("physics/3d/default_gravity"))
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	# If UI (e.g., console) is capturing, ignore gameplay inputs & mouse look.
	if InputRouter.ui_capturing:
		return

	# Mouse look
	if event is InputEventMouseMotion and _mouse_locked:
		var sens: float = mouse_sensitivity * 0.01
		var y_sign: float = (-1.0 if invert_y else 1.0)
		_yaw -= event.relative.x * sens
		_pitch += event.relative.y * sens * y_sign
		_pitch = clamp(_pitch, deg_to_rad(-85), deg_to_rad(85))
		pivot.rotation.x = _pitch
		rotation.y = _yaw

	# Mouse capture toggle (pause key you already mapped to 'pause')
	if event.is_action_pressed("pause"):
		_mouse_locked = not _mouse_locked
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if _mouse_locked else Input.MOUSE_MODE_VISIBLE)

	# Crouch TOGGLE (separate from hold-to-crouch)
	if event.is_action_pressed("crouch_toggle"):
		_crouch_toggle_state = not _crouch_toggle_state

func _physics_process(delta: float) -> void:
	# Gravity always applies
	if not is_on_floor():
		velocity.y -= gravity * delta

	# If UI is capturing (console open), skip gameplay input but keep physics settling
	if InputRouter.ui_capturing:
		move_and_slide()
		return

	# Effective crouch = toggle OR hold action
	var hold_crouch: bool = Input.is_action_pressed("crouch")	# optional; okay if not mapped
	_is_crouching = _crouch_toggle_state or hold_crouch

	# Movement input
	var input_vec: Vector2 = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	).normalized()

	var forward: Vector3 = -global_transform.basis.z
	var right: Vector3 = global_transform.basis.x
	var dir: Vector3 = (forward * input_vec.y + right * input_vec.x)
	dir.y = 0.0
	dir = dir.normalized()

	var speed: float = walk_speed
	if Input.is_action_pressed("sprint") and not _is_crouching:
		speed *= sprint_mult
	if _is_crouching:
		speed *= crouch_mult

	velocity.x = dir.x * speed
	velocity.z = dir.z * speed

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not _is_crouching:
		velocity.y = jump_velocity

	# ADS (hold RMB): swap camera
	_is_ads = Input.is_action_pressed("ads")
	if _is_ads:
		ads_cam.current = true
	else:
		tps_cam.current = true

	move_and_slide()
func get_debug_state() -> Dictionary:
	return {
		"is_ads": _is_ads,
		"is_crouching": _is_crouching,
		"crouch_toggle": _crouch_toggle_state,
		"sprinting": Input.is_action_pressed("sprint"),
		"velocity": velocity,
		"on_floor": is_on_floor(),
		"invert_y": invert_y,
		"mouse_locked": _mouse_locked
	}
