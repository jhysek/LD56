extends Area2D

var direction = Vector2.ZERO
var MOTION_SPEED = 1000
var bounces = 5
var explosive = false

func set_explosive():
	explosive = true
	$Visual/Sprite.texture = load("res://Components/Bullet/explosive.png")

func fire(vector):
	direction = vector
	set_physics_process(true)

func _process(delta: float) -> void:
	rotation += delta * 10
	position += direction * MOTION_SPEED * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Killable"):
		explode()
		body.hit()
	else:
		if explosive:
			explode()

		if bounces <= 0:
			queue_free()
			# TODO explode
		else:
			bounces -= 1
			bounce()
func explode():
	queue_free()

func bounce():
	direction = direction.rotated(PI + (randf_range(-0.4, 0.4)))
