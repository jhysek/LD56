extends Node2D

func boom():
	$AnimationPlayer.play("Boom")
	$HitParticle.emitting = true
	$Boom.play()

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Killable"):
		body.hit()

func gone():
	queue_free()
