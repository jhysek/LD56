class_name PlatformerBody
extends BehaviorResource

@export var GRAVITY_FORCE = 70 * 70;

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
	gravity_angle = character.position.angle_to_point(center_of_gravity)
	gravity_vector = Vector2(cos(gravity_angle), sin(gravity_angle))

	character.gravity_normalized = gravity_vector
	Debug.gravity = gravity_vector * delta * GRAVITY_FORCE * gravity_direction

	character.partial_velocities.gravity = gravity_vector * delta * GRAVITY_FORCE * gravity_direction

# bottom of the character is rotated towards gravity
func lerp_rotation():
	character.up_direction = gravity_vector
	character.look_at(center_of_gravity)
	character.rotation -= PI/2
