extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var w1 = $EnemyWalker.get_behavior_by_name('body')
	w1.unlock_gravity($Arena.global_position)

	if has_node('EnemyWalker2'):
		var w2 = $EnemyWalker2.get_behavior_by_name('body')
		w2.unlock_gravity($Arena.global_position)

	$Arena/Level.hide()
	Transition.openScene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/TextureRect.rotation += delta * 0.1

func _on_button_pressed() -> void:
	Music.play()
	$Click.play()
	LevelSwitcher.current_level = 0
	LevelSwitcher.start_level()

func _on_to_menu_pressed() -> void:
	Transition.switchTo("res://menu.tscn")


func _on_button_mouse_entered() -> void:
	$Click.play()


func _on_button_mouse_exited() -> void:
	$Click.play()
