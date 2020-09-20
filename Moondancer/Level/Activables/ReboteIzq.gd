extends Area2D

var is_alive = false

func _physics_process(delta):
	if get_overlapping_bodies().size() > 1 and Input.is_action_pressed("ui_down") and get_overlapping_bodies()[1].direction == -1:
		is_alive = true
		get_overlapping_bodies()[1].state = 1


func _on_Rebote1_body_exited(body):
	if is_alive:
		is_alive = false
		get_node ("CollisionShape2D").set_deferred("disabled", true)
		yield(get_tree().create_timer(2), "timeout")
		get_node ("CollisionShape2D").set_deferred("disabled", false)
