extends Area2D

var is_inside = false
var player = null

func _physics_process(delta):
	if (is_inside and Input.is_action_pressed("ui_down") ):
		player.state = 3

		get_parent().get_node("AnimationPlayer").play("Caida")
		
		get_node ("CollisionShape2D").set_deferred("disabled", true)
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
		yield(get_tree().create_timer(2), "timeout")
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", false)
		get_node ("CollisionShape2D").set_deferred("disabled", false)


func _on_Caida_body_entered(body):
	if (body.state == 2):
		body.state = 3

		get_parent().get_node("AnimationPlayer").play("Caida")
		
		get_node ("CollisionShape2D").set_deferred("disabled", true)
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
		yield(get_tree().create_timer(2), "timeout")
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", false)
		get_node ("CollisionShape2D").set_deferred("disabled", false)
	
	else:
		is_inside = true
		player = body


func _on_Caida_body_exited(body):
	is_inside = false
	player = null
