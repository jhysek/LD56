extends Area2D

var direction = Vector2.ZERO
var MOTION_SPEED = 2000

func fire(vector):
	direction = vector
	look_at(direction)
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	position += direction * MOTION_SPEED * delta

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.is_in_group("Killable"):
		body.hit()
