extends Node2D


func _ready():
	get_node("Fade/FadeEffect/AnimationPlayer").play("fade_out")
	get_tree().paused = true
	yield(get_node("Fade/FadeEffect/AnimationPlayer"), "animation_finished")
	
	$Intro/Tween.interpolate_property(
		$Intro/Label, "percent_visible", 0, 1, 2.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$Intro/Tween.start()
	yield( get_node("Intro/Tween"), "tween_completed")
	
	$Intro/Accept.visible = true
	

func _on_Accept_pressed():
	get_tree().paused = false
	$Intro.queue_free()
