class_name EnemyJumping
extends BehaviorResource

@export var delay = 2
@export var jump_speed = 3000
var cooldown = delay

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return

	character.grounded = character.is_on_floor()
	character.partial_velocities.jumping = Vector2.ZERO

	if cooldown > 0:
		cooldown -= delta
	else:
		cooldown = delay
		jump()

func jump():
	character.grounded = false
	character.animate("Jump", true)
	character.partial_velocities.jumping = character.gravity_normalized * jump_speed * character.gravity_direction * -1
	character.partial_velocities.gravity = Vector2.ZERO
