extends Node2D

@export var PORTAL_ROTATION_SPEED = 3

@onready var portal = $Center
@onready var spawner = $Center/Spawner
@export var game: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(game, "Game node has to be defined for the arena")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	portal.rotate(delta * PORTAL_ROTATION_SPEED)

func spawn(enemy_scene):
	var enemy = enemy_scene.instantiate()
	game.add_child(enemy)
	enemy.position = spawner.global_position
