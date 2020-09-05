extends Area2D

var is_alive = false

func _on_Rebote1_body_exited(body):
	if is_alive:
		is_alive = false
		print("Esta vivo. Animacion de agua.")
	else:
		print("Esta muerto. Animacion de muerte.")


func _process(delta):
	if get_overlapping_bodies().size() == 2 and Input.is_action_pressed("ui_down"):
		is_alive = true
		print(get_overlapping_bodies().size())
