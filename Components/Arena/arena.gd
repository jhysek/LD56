extends Node2D

@export var PORTAL_ROTATION_SPEED = 3
@export var OBSTACLES = false
@export var ISLAND = true

@onready var portal = $Center
@onready var rotating_layer = $RotatingLayer
@onready var spawner = $Center/Spawner

func _ready():
	$Level.text = "LEVEL   0" + str(LevelSwitcher.current_level + 1)
	if !OBSTACLES:
		$RotatingLayer/Obstacle.queue_free()
		$RotatingLayer/Obstacle2.queue_free()
		$RotatingLayer/Obstacle3.queue_free()
	if !ISLAND:
		$Island.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	portal.rotate(delta * PORTAL_ROTATION_SPEED)
	rotating_layer.rotate(delta * -0.2)

func spawn_position():
	return spawner.global_position

func open_exit():
	if ISLAND:
		$Island.close()
	$Exit.open()

func close_exit():
	if ISLAND:
		$Island.open()
	$Exit.close()
