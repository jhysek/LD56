extends Node

var current_level = 0

var levels = [
	"res://Levels/00.tscn",
	"res://Levels/01.tscn",
	"res://Levels/02.tscn",
	"res://Levels/03.tscn",
	"res://Levels/04.tscn",
	"res://Levels/05.tscn",
	"res://Levels/06.tscn",
	"res://Levels/07.tscn",
	"res://Levels/finished.tscn"
]

func _ready():
	set_process_input(true)

func _input(event):
	if Input.is_action_just_released("ui_restart"):
		restart_level()

	if Input.is_key_pressed(KEY_N) and Input.is_key_pressed(KEY_SHIFT):
		next_level()

func get_current_level():
	return levels[current_level]

func restart_level():
	get_tree().reload_current_scene()

func start_level():
	Transition.switchTo(levels[current_level])

func next_level():
	print("LEVEL: " + str(current_level) + " DONE")
	current_level += 1

	print("Switching to: " + str(current_level) + " / " + levels[current_level])
	if current_level < levels.size():
		start_level()
