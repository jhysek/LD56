class_name PlatformerBody
extends BehaviorResource

@export var GRAVITY_FORCE = 70 * 70;
@export var FLYING = false

var gravity_attractor = null
var center_of_gravity = Vector2(0, 0)
var gravity_direction = -1
var gravity_angle
var gravity_vector

func on_ready(parent):
	character = parent
	character.gravity_normalized = Vector2(0,0)

func on_physics_process(delta):
	if !enabled or character.state == character.State.STATIC:
		return

	calculate_and_apply_gravity(delta)
	lerp_rotation()

func calculate_and_apply_gravity(delta):
	if gravity_attractor:
		center_of_gravity = gravity_attractor.global_position
	gravity_angle = character.position.angle_to_point(center_of_gravity)
	gravity_vector = Vector2(cos(gravity_angle), sin(gravity_angle))

	character.gravity_normalized = gravity_vector

	if !FLYING:
		character.partial_velocities.gravity = gravity_vector * delta * GRAVITY_FORCE * gravity_direction

# bottom of the character is rotated towards gravity
func lerp_rotation():
	character.look_at(center_of_gravity)
	if gravity_direction == -1:
		character.rotation += PI / 2
		character.up_direction = gravity_vector
	else:
		character.rotation -= PI / 2
		character.up_direction = gravity_vector.rotated(PI)

func unlock_gravity(center_pos = Vector2.ZERO):
	gravity_attractor = null
	center_of_gravity = center_pos
	gravity_direction = -1
	character.gravity_direction = -1
	character.speed_damping = 1


func lock_gravity_to(node: Node2D):
	gravity_attractor = node
	center_of_gravity = node.global_position
	gravity_direction = 1
	character.gravity_direction = 1
	character.speed_damping = node.SPEED_DAMPING
