extends Area2D

var direction = Vector2.ZERO
var MOTION_SPEED = 1000
var bounces = 5
var explosive = false
var self_kill_cooldown = 0.5
var shooter
var fired = false
var blink_timeout = 0.2

func set_explosive():
	explosive = true
	$Visual/Sprite.texture = load("res://Components/Bullet/explosive.png")

func fire(vector):
	direction = vector
	fired = true
	set_physics_process(true)

func _process(delta: float) -> void:
	if !fired:
		return

	self_kill_cooldown -= delta
	rotation += delta * 10
	position += direction * MOTION_SPEED * delta

#	if blink_timeout > 0:
#		blink_timeout -= delta
	#else:
	#	blink_timeout = 0.2
	#	switch_color()

func switch_color():
	if modulate == Color("ffffff"):
		modulate = Color('b30060')
	else:
		modulate = Color('ffffff')

func _on_body_entered(body: Node2D) -> void:
	if !fired:
		return

	if body.is_in_group("Killable"):
		hit_body(body)
	else:
		hit_wall()

func hit_body(body):
	if body == shooter and self_kill_cooldown > 0:
		return

	explode()
	body.hit()

func hit_wall():
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
