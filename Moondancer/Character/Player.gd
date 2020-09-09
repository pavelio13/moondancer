extends KinematicBody2D
class_name Player

const TARGET_FPS = 60
const ACCELERATION = 400
const MAX_SPEED = 1200
const FRICTION = 1
const AIR_RESISTANCE = 1
const GRAVITY = 120
const JUMP_FORCE = 5000

enum {
	IDLE,
	WATERWALL,
	WATERNULL,
	WATERFALL,
	JUMP,
	AIR,
	FIRE
}

var motion = Vector2.ZERO
var state = IDLE
var direction = 1
var last_pos = 0.0

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var aquaButton = $UI/Aqua
onready var earthButton = $UI/Earth
onready var fireButton = $UI/Fire
onready var windButton = $UI/Wind

func _physics_process(delta):
#	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var x_input = MAX_SPEED * direction
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("ui_up"):
			$Light2D.color = Color(0, 200, 0, 0.1)
			$Light2D.energy = 0.15
			state = JUMP
			
		if Input.is_action_just_pressed("ui_down") and state != WATERFALL:
			$Light2D.color = Color(0, 0, 200, 0.1)
			$Light2D.energy = 0.15
			state = WATERNULL
			
		if Input.is_action_just_pressed("ui_right") and state == IDLE:
			$Light2D.color = Color(100, 100, 0, 0.1)
			$Light2D.energy = 0.15
			state = AIR
			
		if Input.is_action_just_pressed("ui_left") and state == IDLE:
			$Light2D.color = Color(200, 0, 0, 0.1)
			$Light2D.energy = 0.15
			state = FIRE
	
	if state == IDLE:
		enableButtons()
		if x_input != 0:
			animationPlayer.play("Walk")
			motion.x += x_input * ACCELERATION * delta * TARGET_FPS
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
			$Sprite.flip_h = x_input < 0
			
		if int(last_pos) == int(position.x):
			animationPlayer.play("Die")
			set_physics_process(false)
		last_pos = position.x
	
	elif state == WATERWALL:
		disableButtons()
		animationPlayer.play("WaterWall")
		
	elif state == WATERNULL:
		disableButtons()
		animationPlayer.play("WaterNull")
	
	elif state == WATERFALL:
		disableButtons()
		motion.x = 700*direction
		animationPlayer.play("WaterFall")
	
	elif state == JUMP:
		disableButtons()
		animationPlayer.play("Earth")
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -JUMP_FORCE
		else:
			if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
				motion.y = -JUMP_FORCE/2
		
	elif state == AIR:
		disableButtons()
		animationPlayer.play("Air")
		
	elif state == FIRE:
		disableButtons()
		animationPlayer.play("Fire")
	
	motion.y += GRAVITY * delta * TARGET_FPS	
	motion = move_and_slide(motion, Vector2.UP)


func change_direction():
	direction *= -1


func change_state(new_state):
	state = new_state
	

func enableButtons():
	aquaButton.visible = true
	earthButton.visible = true
	windButton.visible = true
	fireButton.visible = true
	
	
func disableButtons():
	aquaButton.visible = false
	earthButton.visible = false
	windButton.visible = false
	fireButton.visible = false
