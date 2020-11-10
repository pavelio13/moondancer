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
			body.state = 7
			
			
			get_parent().get_parent().get_node("FadeToLobby/FadeEffect/AnimationPlayer").play("fade_in")
			get_parent().get_parent().get_node("FadeToLobby").layer = 111
			yield(get_parent().get_parent().get_node("FadeToLobby/FadeEffect/AnimationPlayer"), "animation_finished")
		
			get_parent().get_parent().queue_free()
			
			var next_level = load("res://Level/Lobby.tscn").instance()
			var player = load("res://Character/Player.tscn").instance()
			
			next_level.add_child(player)
			next_level.set_name("Lobby")
			get_node("/root/Game").add_child(next_level)

			queue_free()
