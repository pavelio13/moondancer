extends Area2D

var is_alive = false

func _on_Rebote1_body_entered(body):
	if body is Player and Input.is_action_pressed("ui_down"):
		is_alive = true


func _on_Rebote1_body_exited(body):
	if is_alive:
		is_alive = false
		print("Esta vivo. Animacion de agua.")
	else:
		print("Esta muerto. Animacion de muerte.")
