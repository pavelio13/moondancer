extends Area2D

func _physics_process(delta):
	if (get_overlapping_bodies().size() == 2 and Input.is_action_pressed("ui_right") ):
		get_overlapping_bodies()[1].state = 5

		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
		yield(get_tree().create_timer(2), "timeout")
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", false)
