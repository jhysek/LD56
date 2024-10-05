class_name EnemyWalking
extends BehaviorResource

@export var WALK_SPEED: int = 70000
@export var should_walk_left: bool = true

var direction: Vector2 = Vector2.ZERO
var moving = false

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return

	character.grounded = character.is_on_floor()
	character.partial_velocities.walking = Vector2.ZERO

	if should_walk_left:
		walk_left(delta)
	else:
		walk_right(delta)

	if !moving:
		character.partial_velocities.walking = Vector2.ZERO
		if character.grounded:
			character.animate('Idle')

func walk_left(delta):
	moving = true
	var left_vector = character.gravity_normalized.rotated(-PI/2)
	character.partial_velocities.walking += left_vector * WALK_SPEED * delta
	character.animate('WalkLeft')

func walk_right(delta):
	moving = true
	var right_vector = character.gravity_normalized.rotated(PI/2)
	character.partial_velocities.walking += right_vector * WALK_SPEED * delta
	character.animate('WalkRight')
