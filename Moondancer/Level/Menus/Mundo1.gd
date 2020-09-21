extends Control

var start_position_seconds = 0.0

func _on_Next_pressed():
	if start_position_seconds >= 0.0 and start_position_seconds <= 0.0:
		$AnimationPlayer.seek(start_position_seconds, true)
		$AnimationPlayer.play("next")
		start_position_seconds += 1.2


func _on_Prev_pressed():
	if start_position_seconds >= 1.2 and start_position_seconds <= 1.2:
		$AnimationPlayer.seek(start_position_seconds, true)
		$AnimationPlayer.play_backwards("next")
		start_position_seconds -= 1.2


func _on_Accept_pressed():	
	if start_position_seconds == 0:
		
		get_parent().get_parent().queue_free()
		
		var next_level = load("res://Level/Tutorial.tscn").instance()
		var player = load("res://Character/Player.tscn").instance()
		next_level.add_child(player)
		next_level.set_name("Tutorial")
		get_node("/root/Game").add_child(next_level)

		queue_free()
