class_name BehaviorShooting
extends BehaviorResource

var Bullet = load("res://Components/Bullet/bullet.tscn")

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return

	if Input.is_action_just_pressed("ui_attack"):
		fire()

func fire():
	var bullet = Bullet.instantiate()
	bullet.look_at(character.gravity_normalized * -1)
	character.game.add_child(bullet)
	bullet.position = character.global_position
	if character.gravity_direction == -1:
		bullet.fire(character.gravity_normalized)
	else:
		bullet.fire(character.gravity_normalized * -1)
