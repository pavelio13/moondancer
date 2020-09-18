extends Control


func _on_Start_pressed():
	get_node("FadeEffect").visible = true
	get_node("FadeEffect/AnimationPlayer").play("fade")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Game.tscn")



func _on_Exit_pressed():
	get_tree().quit()


