extends Area2D


func _on_Destruir_area_entered(body):
	if "Fireball" in body.name:
		get_parent().get_node("AnimatedSprite").play("Destroy")
		get_parent().z_index = 15
		$Light2D.enabled = true
		yield(get_tree().create_timer(0.2), "timeout")
		get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
		$Light2D.energy = 0.5
		yield(get_tree().create_timer(0.2), "timeout")
		$Light2D.energy = 0
