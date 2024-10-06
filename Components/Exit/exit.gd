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

func switch_color():
	if $Border/Indicator.modulate == Color("ffffff"):
		$Border/Indicator.modulate = Color("ff0ffb")
	else:
		$Border/Indicator.modulate = Color("ffffff")

func open():
	opened = true
	$AnimationPlayer.play("Open")
	$Border/Indicator.modulate = Color("72b500")

func close():
	opened = false
	$AnimationPlayer.play_backwards("Open")
	$Border/Indicator.modulate = Color("ff0ffb")


func _on_body_entered(body: Node2D) -> void:
	if opened and body.name == "Player":
		print("DONE")
		body.fadeOut()
		close()
		LevelSwitcher.next_level()
