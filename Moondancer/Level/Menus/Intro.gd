extends Node2D


func _ready():
	get_tree().paused = true
	

func _on_Accept_pressed():
	get_tree().paused = false
	$Intro.queue_free()
