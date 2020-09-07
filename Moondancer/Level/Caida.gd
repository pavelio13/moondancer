extends Area2D

func _process(delta):
	if (get_overlapping_bodies().size() == 2 and Input.is_action_pressed("ui_down") ):
		get_overlapping_bodies()[1].state = 3

		get_node ("CollisionShape2D").set_deferred("disabled", true)
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
		yield(get_tree().create_timer(2), "timeout")
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", false)
		get_node ("CollisionShape2D").set_deferred("disabled", false)


func _on_Caida1_body_entered(body):
	if (get_overlapping_bodies().size() == 2 and get_overlapping_bodies()[1].state == 2):
		get_overlapping_bodies()[1].state = 3

		get_node ("CollisionShape2D").set_deferred("disabled", true)
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
		yield(get_tree().create_timer(2), "timeout")
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", false)
		get_node ("CollisionShape2D").set_deferred("disabled", false)
