extends Area2D

var is_inside = false
var player = null

func _physics_process(delta):
	if (is_inside and Input.is_action_pressed("ui_up") ):
		player.state = 4
		
		get_parent().get_node("AnimationPlayer").play("Salto")

		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", true)
		yield(get_tree().create_timer(1.5), "timeout")
		get_parent().get_parent().get_node("CollisionShape2D").set_deferred("disabled", false)


func _on_Subida_body_entered(body):
	is_inside = true
	player = body


func _on_Subida_body_exited(body):
	is_inside = false
	player = null
