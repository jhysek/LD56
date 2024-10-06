extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level.hide()
	Transition.openScene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/TextureRect.rotation += delta * 0.1

func _on_button_pressed() -> void:
	LevelSwitcher.current_level = 0
	LevelSwitcher.start_level()

func _on_to_menu_pressed() -> void:
	Transition.switchTo("res://menu.tscn")
