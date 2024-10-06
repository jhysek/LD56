extends BehaviorCharacter

func _ready():
	$Visual/Body/Weapon.queue_free()
	super()
	$Visual/Body/Leg1.queue_free()
	$Visual/Body/Leg2.queue_free()
	$Visual/Body/Leg3.queue_free()
	$Visual/Body/Leg4.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
