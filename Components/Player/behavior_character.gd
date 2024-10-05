class_name BehaviorCharacter
extends CharacterBody2D

var BehaviorResource = load("res://Components/Player/Resources/BehaviorResource.gd")

enum State {
	STATIC,
	PAUSED,
	IDLE,
	DEAD
}

@export var behaviors: Array[BehaviorResource];
@export var state: State = State.IDLE;
@onready var anim = $AnimationPlayer

var gravity_normalized: Vector2
var grounded: bool = false
var gravity_velocity = Vector2.ZERO

var partial_velocities = {
	gravity = Vector2(0,0),
	walking = Vector2(0,0),
	jumping = Vector2(0,0)
}

func _ready():
	for_each_behavior("on_ready", self)

func _process(delta):
	for_each_behavior("on_process", delta)
	Debug.velocity = velocity

func _physics_process(delta):
	for_each_behavior("on_physics_process", delta)

	velocity += partial_velocities.gravity
	velocity += partial_velocities.jumping

	if grounded:
		if partial_velocities.walking == Vector2.ZERO:
			velocity = Vector2.ZERO
		else:
			velocity = partial_velocities.walking
	else:
		velocity += partial_velocities.walking * 0.1

	move_and_slide()
	velocity = get_real_velocity()

func _input(event):
	for_each_behavior("on_input", event)

func for_each_behavior(function_name, argument = null):
	for behavior in behaviors:
		if behavior != null and behavior.has_method(function_name):
			var callable = Callable(behavior, function_name)
			callable.call(argument)

func get_behavior_by_name(resource_name):
	for behavior in behaviors:
		if behavior.resource_name == resource_name:
			return behavior
	return null

func enable_behavior(resource_name):
	var behavior = get_behavior_by_name(resource_name)
	if behavior:
		behavior.enable()

func disable_behavior(resource_name):
	var behavior = get_behavior_by_name(resource_name)
	if behavior:
		behavior.disable

func animate(anim_name, force = false):
	if anim.current_animation != anim_name or force:
		print("SWITCHING TO ANIMATION: " + anim_name)
		anim.play(anim_name)
