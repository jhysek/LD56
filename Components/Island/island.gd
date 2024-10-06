extends StaticBody2D

@export var SPEED_DAMPING = 0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_gravity_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("GravityBody"):
		var body_behavior = body.get_behavior_by_name('body')
		if body_behavior:
			body_behavior.lock_gravity_to(self)


func _on_gravity_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("GravityBody"):
		var body_behavior = body.get_behavior_by_name('body')
		if body_behavior:
			body_behavior.unlock_gravity()

func close():
	$AnimationPlayer.play("Close")

func open():
	$AnimationPlayer.play("Open")
