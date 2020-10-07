extends Area2D


func _on_Accept_pressed():
	get_tree().paused = false
	queue_free()


func _on_Tutorial_body_entered(body):
	get_tree().paused = true
	
	$DialogBox/Tween.interpolate_property(
		$DialogBox/Label, "percent_visible", 0, 1, 2.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$DialogBox/Tween.start()
	yield( get_node("DialogBox/Tween"), "tween_completed")
	
	$DialogBox/Accept.visible = true
