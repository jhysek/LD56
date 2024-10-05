class_name BehaviorAttacking
extends BehaviorResource

func on_ready(parent):
	character = parent

func on_physics_process(delta):
	if !enabled:
		return
