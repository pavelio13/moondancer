extends Area2D


const SPEED = 3000
var velocity = Vector2()
var direction = 1


func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("fireball")


func set_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Fireball_body_entered(body):
	if not (body is KinematicBody2D):
#		$AnimatedSprite.play("destroy")
		queue_free()
