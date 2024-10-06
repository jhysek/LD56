class_name EnemyShooting
extends BehaviorResource

@export var SHOOTING_UP = true
@export var SHOOTING_DOWN = false
@export var EXPLODING = false

var Bullet = load("res://Components/Bullet/bullet.tscn")

@export var delay = 2.5
var cooldown = delay

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return

	character.grounded = character.is_on_floor()

	if cooldown > 0:
		cooldown -= delta
	else:
		cooldown = delay
		fire()

func fire():
	character.play_audio("Shoot", true)
	var bullet = Bullet.instantiate()
	bullet.shooter = character
	character.game.add_child(bullet)
	if character.has_node('FirePos'):
		bullet.position = character.get_node('FirePos').global_position
	else:
		bullet.position = character.global_position

	if SHOOTING_DOWN:
		bullet.set_explosive()
		bullet.fire(character.gravity_normalized.rotated(character.get_parent().rotation + PI))
		return

	if EXPLODING:
		bullet.set_explosive()

	if character.gravity_direction == -1:
		# Fire UP
		if SHOOTING_UP:
			bullet.bounces = 5
			bullet.fire(character.gravity_normalized)
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
