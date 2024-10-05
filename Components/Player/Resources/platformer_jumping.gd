class_name PlatformerJumping
extends BehaviorResource

signal on_jumped
signal on_double_jumped
signal on_flapped

@export var JUMP_SPEED: int = 2000
@export var DOUBLE_JUMP_SPEED  = 3000
var COYOTE_TIME: int = 0.12
@export var DOUBLE_JUMP: bool = false
var FLAPPY_BIRD: bool = false

var in_air: bool = false
var double_jumped: bool = false
var jump_timeout: float = 0.0

func on_physics_process(delta):
	if !enabled:
		return

	character.partial_velocities.jumping = Vector2.ZERO

	var grounded = character.is_on_floor()
	Debug.grounded = grounded
	character.grounded = grounded
	var jump_speed = JUMP_SPEED

	in_air = !grounded
	_handle_coyote_time(delta, grounded)

	if (grounded or !double_jumped) and Input.is_action_just_pressed("ui_jump"):
		character.grounded = false
		Debug.grounded = false

		if in_air and !DOUBLE_JUMP and !FLAPPY_BIRD:
			return

		if in_air and DOUBLE_JUMP and !FLAPPY_BIRD:
			double_jumped = true
			jump_speed = DOUBLE_JUMP_SPEED
			emit_signal("on_double_jumped")
		else:
			in_air = true
			double_jumped = false
			if FLAPPY_BIRD:
				emit_signal("on_flapped")
			else:
				emit_signal("on_jumped")

		jump_timeout = 0

		Debug.jump =  character.gravity_normalized * jump_speed
		print("NORM: ", character.gravity_normalized)
		print("JUMP SPEED: ", jump_speed)

		character.partial_velocities.jumping = character.gravity_normalized * jump_speed
		character.partial_velocities.gravity = Vector2.ZERO


func _handle_coyote_time(delta, grounded):
	if grounded:
		in_air = false
		double_jumped = true
		jump_timeout = 0

	elif !in_air and jump_timeout <= 0:
		jump_timeout = COYOTE_TIME

	if jump_timeout > 0:
		jump_timeout -= delta
		if jump_timeout <= 0:
			in_air = true
