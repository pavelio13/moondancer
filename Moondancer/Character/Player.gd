extends KinematicBody2D
class_name Player

const TARGET_FPS = 60
const ACCELERATION = 400
const MAX_SPEED = 1200
const FRICTION = 1
const AIR_RESISTANCE = 1
const GRAVITY = 120
const JUMP_FORCE = 5000

const FIREBALL = preload("res://Character/Fireball.tscn")

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
	var x_input = MAX_SPEED * direction
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("ui_up"):
			$Light2D.color = Color("#1edd1e")
			$Light2D.energy = 0.75
			state = JUMP
			
		if Input.is_action_just_pressed("ui_down") and state != WATERFALL:
			$Light2D.color = Color("#28aae4")
			$Light2D.energy = 0.75
			state = WATERNULL
			
		if Input.is_action_just_pressed("ui_right") and state == IDLE:
			$Light2D.color = Color("#fdfd00")
			$Light2D.energy = 0.75
			state = AIR
			
		if Input.is_action_just_pressed("ui_left") and state == IDLE:
			$Light2D.color = Color("#f44623")
			$Light2D.energy = 0.75
			state = FIRE
	
	if state == IDLE:
		changeButtons(true, true, true, true)
		if x_input != 0:
			animationPlayer.play("Walk")
			motion.x += x_input * ACCELERATION * delta * TARGET_FPS
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
			$Sprite.flip_h = x_input < 0
			$Position2D.position.x *= direction
			if direction == 1:
				$Light2D2.rotation_degrees = 30
			else:
				$Light2D2.rotation_degrees = -30
				
			
		if int(last_pos) == int(position.x):
			animationPlayer.play("Die")
			set_physics_process(false)
			yield(get_tree().create_timer(2), "timeout")
			set_physics_process(true)
			position = Stats.spawnpoint
			direction = Stats.direction
			$Sprite.modulate = Color(1,1,1,1)
			
		last_pos = position.x
	
	elif state == WATERWALL:
		changeButtons(true, false, false, false)
		animationPlayer.play("WaterWall")
		
	elif state == WATERNULL:
		changeButtons(true, false, false, false)
		animationPlayer.play("WaterNull")
	
	elif state == WATERFALL:
		changeButtons(true, false, false, false)
		motion.x = 700*direction
		animationPlayer.play("WaterFall")
	
	elif state == JUMP:
		changeButtons(false, true, false, false)
		animationPlayer.play("Earth")
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -JUMP_FORCE
		else:
			if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
				motion.y = -JUMP_FORCE/2
		
	elif state == AIR:
		changeButtons(false, false, false, false)
		motion.x = 800*direction
		animationPlayer.play("Air")
		
	elif state == FIRE:
		changeButtons(false, false, false, false)
		animationPlayer.play("Fire")
	
	motion.y += GRAVITY * delta * TARGET_FPS	
	motion = move_and_slide(motion, Vector2.UP)


func change_direction():
	direction *= -1


func change_state(new_state):
	state = new_state
	

func changeButtons(aqua, earth, wind, fire):
	aquaButton.visible = aqua
	earthButton.visible = earth
	windButton.visible = wind
	fireButton.visible = fire

func shoot_fireball():
	var fireball = FIREBALL.instance()
	fireball.set_direction(direction)
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
