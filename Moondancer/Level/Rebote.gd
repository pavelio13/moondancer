extends Area2D

var is_alive = false

func _on_Rebote1_body_exited(body):
	if is_alive:
		is_alive = false
		body.state = 0


func _process(delta):
	if get_overlapping_bodies().size() == 2 and Input.is_action_pressed("ui_down"):
		is_alive = true
		get_overlapping_bodies()[1].state = 1
