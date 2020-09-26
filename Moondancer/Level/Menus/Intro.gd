extends Node2D


func _ready():
	get_node("Fade/FadeEffect/AnimationPlayer").play("fade_out")
	get_tree().paused = true
	yield(get_node("Fade/FadeEffect/AnimationPlayer"), "animation_finished")
	

func _on_Accept_pressed():
	get_tree().paused = false
	$Intro.queue_free()
