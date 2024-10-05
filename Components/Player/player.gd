extends BehaviorCharacter

@export var is_enemy = false
@export var health = 4

func _ready():
	if is_enemy:
		$Visual/Body/Weapon/Bottom/WeaponArea.queue_free()
	super()

func _on_weapon_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("WEAPON SLASH")
		body.queue_free()

func _on_jump_attack_weapon_body_entered(body: Node2D) -> void:
	if !grounded and body.is_in_group("Enemy"):
		print("BOOM")
		body.queue_free()

func boost():
	$Visual/Booster.show()
	$Booster.start()

func _on_booster_timeout() -> void:
	$Visual/Booster.hide()

func hit():
	health -= 1
	print("HIT! current health: ", health)
	if health <= 0:
		die()

func die():
	print("DEAD....")
