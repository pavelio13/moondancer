extends Area2D


func _on_Detector_body_entered(body):
	if "Player" in body.name:
		if Stats.waterButton and Stats.earthButton and Stats.fireButton and Stats.airButton:
			body.set_physics_process(false)
			get_parent().get_node("CollisionShape2D").queue_free()
			get_parent().get_node("AnimatedSprite").play("puertaAbierta")
			yield(get_tree().create_timer(1.3), "timeout")
			get_parent().get_node("AnimatedSprite").stop()
			body.set_physics_process(true)
			yield(get_tree().create_timer(0.5), "timeout")
			get_tree().change_scene("res://Level/Backgrounds/FinalBackground.tscn")
			
