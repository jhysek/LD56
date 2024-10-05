extends Control

@export var value = 1

func change(new_value):
	if new_value != value:
		value = new_value
		$AnimationPlayer.stop()
		$AnimationPlayer.play("Change")

func update_value():
	$Container/Label.text = str(value)
