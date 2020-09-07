extends KinematicBody2D
class_name Player

const TARGET_FPS = 60
const ACCELERATION = 400
const MAX_SPEED = 1200
const FRICTION = 1
const AIR_RESISTANCE = 1
const GRAVITY = 100
const JUMP_FORCE = 3500

enum {
	IDLE,
	WATERWALL,
	WATERNULL,
	WATERFALL
}

var motion = Vector2.ZERO
var state = IDLE
var direction = 1

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var aquaButton = $UI/Aqua
onready var earthButton = $UI/Earth
onready var fireButton = $UI/Fire
onready var windButton = $UI/Wind

func _physics_process(delta):
#	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var x_input = MAX_SPEED * direction
	
	if state == IDLE:
		aquaButton.visible = true
		if x_input != 0:
			$Sprite2.hide()
			$Sprite3.hide()
			$Sprite4.hide()
			$Sprite.show()
			animationPlayer.play("Walk")
			motion.x += x_input * ACCELERATION * delta * TARGET_FPS
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
			$Sprite.flip_h = x_input < 0
			$Sprite2.flip_h = x_input < 0
			$Sprite3.flip_h = x_input < 0
			$Sprite4.flip_h = x_input < 0
		else:
			animationPlayer.play("Walk")
	
	elif state == WATERWALL:
		$Sprite.hide()
		$Sprite2.show()
		aquaButton.visible = false
		animationPlayer.play("WaterWall")
		
	elif state == WATERNULL:
		$Sprite.hide()
		$Sprite3.show()
		aquaButton.visible = false
		animationPlayer.play("WaterNull")
	
	elif state == WATERFALL:
		$Sprite.hide()
		$Sprite3.hide()
		$Sprite4.show()
		aquaButton.visible = false
		animationPlayer.play("WaterFall")
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
			
		if Input.is_action_just_pressed("ui_down"):
			state = WATERNULL
			
	else:
		animationPlayer.play("Walk")
		
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE * delta)
	
	motion = move_and_slide(motion, Vector2.UP)


func change_direction():
	direction *= -1


func change_state(new_state):
	state = new_state
