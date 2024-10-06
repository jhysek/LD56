extends Node2D

var EnemyWalker = load("res://Components/Enemies/enemy_walker.tscn")

@onready var spawn_timer = $SpawnTimer

var current_wave_idx = 0
var current_wave

var enemies = []

var WAVES = [
	{
		wait_time = 1,
		enemies = [

		]
	},
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Transition.openScene()
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemies.append(enemy)
		print("> connecting: ", enemy.name)
		enemy.killed.connect(_on_enemy_killed)
	update_enemy_counter()
	start_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/TextureRect.rotation += delta * 0.1
	$Debug/Velocity.text = "VELOCITY: " + str(Debug.velocity)
	$Debug/Grounded.text = "GROUNDED: " + str(Debug.grounded)
	$RotatingLayer.rotation -= delta * 0.4

func _on_spawn_timeout() -> void:
	if !current_wave:
		return

	if current_wave.enemies.size() > 0:
		spawn(current_wave.enemies.pop_front())
		spawn_timer.start()
	else:
		$Info.text = "WAVE " + str(current_wave_idx + 1) + " deployed"

func start_wave():
	if WAVES.size() > 0:
		current_wave = WAVES.pop_front()
		$WaveTimer.wait_time = current_wave.wait_time
		$WaveTimer.start()
	else:
		print("GAME FINISHED")

func _on_wave_timer_timeout() -> void:
	$Info.text = "WAVE " + str(current_wave_idx + 1) + " incoming..."
	spawn_timer.start()

func spawn(enemy_scene):
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	enemies.append(enemy)
	print("> connecting: ", enemy.name)
	enemy.killed.connect(_on_enemy_killed)
	enemy.position = $Arena.spawn_position()
	update_enemy_counter()

func _on_enemy_killed(enemy):
	enemies.erase(enemy)
	update_enemy_counter()
	if enemies.size() <= 0:
		open_exit()

func _on_jump_attack_weapon_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemy"):
		print("AREA: ", area.name)

func update_enemy_counter():
	$Screen/Enemies.text = str(enemies.size())

func open_exit():
	$Arena.open_exit()
