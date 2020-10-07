extends CanvasLayer

var start_position_seconds = 0.0

func _on_Next_pressed():
	if start_position_seconds >= 0.0 and start_position_seconds <= 0.0:
		$AnimationPlayer.play("next")
		start_position_seconds += 1.2


func _on_Prev_pressed():
	if start_position_seconds >= 1.2 and start_position_seconds <= 1.2:
		$AnimationPlayer.play_backwards("next")
		start_position_seconds -= 1.2


func _on_Accept_pressed():
	$AnimationPlayer.play("out")
	yield($AnimationPlayer, "animation_finished")
	get_parent().get_parent().get_node("FadeWorld/FadeEffect/AnimationPlayer").play("fade_in")
	yield(get_parent().get_parent().get_node("FadeWorld/FadeEffect/AnimationPlayer"), "animation_finished")
	
	if start_position_seconds == 0:
		
		get_parent().get_parent().queue_free()
		
		var next_level = load("res://Level/Level1-1.tscn").instance()
		var player = load("res://Character/Player.tscn").instance()
		
		player.global_position = next_level.get_node("Spawn").position
		
		next_level.add_child(player)
		next_level.set_name("Tutorial")
		get_node("/root/Game").add_child(next_level)

		queue_free()
