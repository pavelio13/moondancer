extends Control


func _on_Start_pressed():
	get_node("FadeEffect").visible = true
	get_node("FadeEffect/AnimationPlayer").play("fade_in")
	yield(get_node("FadeEffect/AnimationPlayer"), "animation_finished")
	get_tree().change_scene("res://Game.tscn")



func _on_Exit_pressed():
	get_tree().quit()


