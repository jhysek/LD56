extends Node2D

var EnemyWalker = load("res://Components/Enemies/enemy_walker.tscn")

@onready var spawn_timer = $SpawnTimer

var current_wave_idx = 0
var current_wave

var WAVES = [
	{
		wait_time = 1,
		enemies = [
			EnemyWalker
		]
	},
	{
		wait_time = 5,
		enemies = [
			EnemyWalker, EnemyWalker, EnemyWalker, EnemyWalker
		]
	},
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Transition.openScene()
	start_wave()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/TextureRect.rotation += delta * 0.1
	$Debug/Velocity.text = "VELOCITY: " + str(Debug.velocity)
	$Debug/Grounded.text = "GROUNDED: " + str(Debug.grounded)

func _on_spawn_timeout() -> void:
	if !current_wave:
		return

	if current_wave.enemies.size() > 0:
		$Arena.spawn(current_wave.enemies.pop_front())
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


func _on_jump_attack_weapon_area_entered(area: Area2D) -> void:
	print(area.get_groups())
	if area.is_in_group("Enemy"):
		print("AREA: ", area.name)
