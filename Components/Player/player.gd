extends BehaviorCharacter

@export var is_enemy = false
@export var skin = "Spider"

func _ready():
	if is_enemy:
		$Visual/Body/Weapon/Bottom/WeaponArea.queue_free()

	if skin != "Spider":
		reload_skin()
	super()

func _on_weapon_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.hit()

func _on_jump_attack_weapon_body_entered(body: Node2D) -> void:
	if !grounded and body.is_in_group("Enemy"):
		jumpattack = true
		body.hit()

func boost():
	$Sfx/Boost.play()
	$Visual/Booster.show()
	$Booster.start()

func _on_booster_timeout() -> void:
	$Visual/Booster.hide()

func fadeOut():
	$AnimationPlayer.play("FadeOut")

func reload_skin():
	$Visual/Body.texture = load("res://Components/Player/" + skin + "/body.png")
	$Visual/Body/Leg1.texture = load("res://Components/Player/" + skin + "/leg_up.png")
	$Visual/Body/Leg1/Bottom.texture = load("res://Components/Player/" + skin + "/leg_down.png")
	$Visual/Body/Leg2.texture = load("res://Components/Player/" + skin + "/leg_up.png")
	$Visual/Body/Leg2/Bottom.texture = load("res://Components/Player/" + skin + "/leg_down.png")
	$Visual/Body/Leg3.texture = load("res://Components/Player/" + skin + "/leg_up.png")
	$Visual/Body/Leg3/Bottom.texture = load("res://Components/Player/" + skin + "/leg_down.png")
	$Visual/Body/Leg4.texture = load("res://Components/Player/" + skin + "/leg_up.png")
	$Visual/Body/Leg4/Bottom.texture = load("res://Components/Player/" + skin + "/leg_down.png")


func _on_jump_area_body_entered(body: Node2D) -> void:
	if body == self:
		return

	if state == State.DEAD:
		return

	if body.name == "Player" and !body.jumpattack:
		body.hit()
		return

	if !grounded and body.is_in_group("Enemy"):
		jumpattack = true
		body.hit()
