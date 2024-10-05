class_name BehaviorAttacking
extends BehaviorResource

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return

	if Input.is_action_just_pressed("ui_attack"):
		character.get_node("Visual/Body/Leg3").hide()
		character.get_node("Visual/Body/Weapon").show()
		character.get_node("AttackAnim").stop()
		character.get_node("AttackAnim").play("Attack")
