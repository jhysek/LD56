class_name BehaviorShooting
extends BehaviorResource

@export var SHOOTING_UP = false

var Bullet = load("res://Components/Bullet/bullet.tscn")

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return

	if Input.is_action_just_pressed("ui_attack"):
		fire()

func fire():
	character.play_audio("Shoot", true)
	var bullet = Bullet.instantiate()
	bullet.shooter = character
	character.game.add_child(bullet)
	bullet.position = character.global_position
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
