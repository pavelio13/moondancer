extends KinematicBody2D
class_name Player

const TARGET_FPS = 60
const ACCELERATION = 400
const MAX_SPEED = 1200
const FRICTION = 1
const AIR_RESISTANCE = 1
const GRAVITY = 100
const JUMP_FORCE = 3500

var motion = Vector2.ZERO
var state = 0
var direction = 1

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
#	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var x_input = MAX_SPEED * direction
	
	if state == 0:
		if x_input != 0:
			$Sprite2.hide()
			$Sprite.show()
			animationPlayer.play("Walk")
			motion.x += x_input * ACCELERATION * delta * TARGET_FPS
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
			$Sprite.flip_h = x_input < 0
			$Sprite2.flip_h = x_input < 0
		else:
			animationPlayer.play("Walk")
	
	elif state == 1:
		$Sprite.hide()
		$Sprite2.show()
		animationPlayer.play("WaterWall")
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
			
		if Input.is_action_just_pressed("ui_down"):
			$Sprite.hide()
			$Sprite2.show()
			animationPlayer.play("WaterWall")
			state = 3
	else:
		animationPlayer.play("Walk")
		
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	motion = move_and_slide(motion, Vector2.UP)


func change_direction():
	direction *= -1
	state = 0
