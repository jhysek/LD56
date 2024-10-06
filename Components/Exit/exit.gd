extends Area2D

var opened = false
var blink_timeout = 0.5
var status_color = "ff0ffb"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta):
	$Border/Indicator.rotate(delta * 10)
	if opened:
		$Hole.rotate(delta * -10)
		return

func open():
	opened = true
	$Open.play()
	$AnimationPlayer.play("Open")

func close():
	$Open.play()
	opened = false
	$AnimationPlayer.play_backwards("Open")

func _on_body_entered(body: Node2D) -> void:
	if opened and body.name == "Player":
		print("DONE")
		body.fadeOut()
		close()
		LevelSwitcher.next_level()
