class_name EnemyShooting
extends BehaviorResource

@export var SHOOTING_UP = true
var Bullet = load("res://Components/Bullet/bullet.tscn")

@export var delay = 3
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
		fire()

func fire():
	var bullet = Bullet.instantiate()
	character.game.add_child(bullet)
	bullet.position = character.global_position
	if character.gravity_direction == -1:
		# Fire UP
		if SHOOTING_UP:
			bullet.bounces = 5
			bullet.fire(character.gravity_normalized * -1)
		else:
			# Fire in front
			bullet.bounces = 0
			bullet.set_explosive()
			bullet.fire(character.gravity_normalized.rotated(PI / 2 * character.direction * -1).rotated(PI / 4 * character.direction))
	else:
		# Fire UP
		if SHOOTING_UP:
			bullet.bounces = 5
			bullet.fire(character.gravity_normalized * -1)
		else:
			# Fire in front
			bullet.bounces = 0
			bullet.set_explosive()
			bullet.fire(character.gravity_normalized.rotated(PI / 2 * character.direction * -1))
