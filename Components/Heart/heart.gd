extends Node2D

func start(at):
	position = at
	$Sprite/AnimationPlayer.play("Tween")

func _on_animation_player_animation_finished(anim_name):
	queue_free()
