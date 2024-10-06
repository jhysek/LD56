class_name PlatformerWalking
extends BehaviorResource

@export var WALK_SPEED: int = 90000
var in_air_dumping = 0.1

var direction: Vector2 = Vector2.ZERO

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return

	var direction = Vector2.ZERO
	var dumping = 1
	var moving = false
	character.partial_velocities.walking = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		moving = true
		var left_vector = character.gravity_normalized.rotated(-PI/2)
		direction += left_vector
		character.partial_velocities.walking += left_vector * WALK_SPEED * delta * dumping * character.speed_damping
		character.direction = 1
		if character.grounded:
			if character.gravity_direction == -1:
				character.animate('WalkLeft')
			else:
				character.animate('WalkRight')


	if Input.is_action_pressed("ui_right"):
		moving = true
		var right_vector = character.gravity_normalized.rotated(PI/2)
		direction += right_vector
		character.partial_velocities.walking += right_vector * WALK_SPEED * delta * dumping * character.speed_damping
		character.direction = -1
		if character.grounded:
			if character.gravity_direction == -11:
				character.animate('WalkRight')
			else:
				character.animate('WalkLeft')

	if !moving:
		character.partial_velocities.walking = Vector2.ZERO
		if character.grounded:
			character.animate('Idle')
		character.stop_audio('Run')
	else:
		character.play_audio('Run')
