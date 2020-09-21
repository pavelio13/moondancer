extends Area2D


func _on_Mundo_body_entered(body):
	var newWorld = load("res://Level/Menus/"+name+".tscn").instance()
	body.add_child(newWorld)
	body.set_physics_process(false)
