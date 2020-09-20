extends KinematicBody2D
class_name Player

const TARGET_FPS = 60
const ACCELERATION = 100
const MAX_SPEED = 300
const FRICTION = 1
const AIR_RESISTANCE = 1
const GRAVITY = 30
const JUMP_FORCE = 1250

const FIREBALL = preload("res://Character/Fireball.tscn")

enum {
	IDLE,
	WATERWALL,
	WATERNULL,
	WATERFALL,
	JUMP,
	AIR,
	FIRE,
	PORTAL
}

var motion = Vector2.ZERO
var state = IDLE
var direction = 1
var last_pos = 0.0
var is_alive = true

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var aquaButton = $UI/Aqua
onready var earthButton = $UI/Earth
onready var fireButton = $UI/Fire
onready var windButton = $UI/Wind

func _ready():
	set_physics_process(false)
	get_node("Fade/FadeEffect").visible = true
	get_node("Fade/FadeEffect/AnimationPlayer").play_backwards("fade")
	yield(get_tree().create_timer(2), "timeout")
	get_node("Fade/FadeEffect").visible = false
	set_physics_process(true)


func _physics_process(delta):
	var x_input = MAX_SPEED * direction
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
			
		if Input.is_action_just_pressed("ui_up"):
			$Light2D.color = Color("#1edd1e")
			state = JUMP
			
		if Input.is_action_just_pressed("ui_down") and state != WATERFALL:
			$Light2D.color = Color("#28aae4")
			state = WATERNULL
			
		if Input.is_action_just_pressed("ui_right") and state == IDLE:
			$Light2D.color = Color("#fdfd00")
			state = AIR
			
		if Input.is_action_just_pressed("ui_left") and state == IDLE:
			$Light2D.color = Color("#f44623")
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
				
			
		if int(last_pos) == int(position.x) and is_alive:
			animationPlayer.play("Die")
			is_alive = false
			set_physics_process(false)
			yield(get_tree().create_timer(1.5), "timeout")
			position = Stats.spawnpoint
			direction = Stats.direction
			
		last_pos = position.x
	
	elif state == WATERWALL:
		changeButtons(true, false, false, false)
		animationPlayer.play("WaterWall")
		
	elif state == WATERNULL:
		changeButtons(true, false, false, false)
		animationPlayer.play("WaterNull")
	
	elif state == WATERFALL:
		changeButtons(true, false, false, false)
		motion.x = 175*direction
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
		motion.x = 200*direction
		animationPlayer.play("Air")
		
	elif state == FIRE:
		changeButtons(false, false, false, false)
		animationPlayer.play("Fire")
		
	elif state == PORTAL:
		changeButtons(false, false, false, false)
		if motion.x != 0:
			animationPlayer.play("PortalIn")
			yield(get_tree().create_timer(0.7), "timeout")
			get_node("Tutorial").visible = true
			
			if Stats.earthButton:
				get_node("Tutorial/Panel/AnimatedSprite").play("earthTutorial")
			if Stats.waterButton:
				get_node("Tutorial/Panel/AnimatedSprite").play("waterTutorial")
			if Stats.fireButton:
				get_node("Tutorial/Panel/AnimatedSprite").play("fireTutorial")
			if Stats.airButton:
				get_node("Tutorial/Panel/AnimatedSprite").play("airTutorial")
			
		motion.x = 0
		
	else:
		print("Error")
	
	motion.y += GRAVITY * delta * TARGET_FPS	
	motion = move_and_slide(motion, Vector2.UP)


func change_direction():
	direction *= -1


func change_state(new_state):
	state = new_state
	

func changeButtons(aqua, earth, wind, fire):
	if Stats.waterButton:
		aquaButton.visible = aqua
	if Stats.earthButton:
		earthButton.visible = earth
	if Stats.airButton:
		windButton.visible = wind
	if Stats.fireButton:
		fireButton.visible = fire

func shoot_fireball():
	var fireball = FIREBALL.instance()
	fireball.set_direction(direction)
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
	fireball.z_index = 20
	
func set_alive():
	is_alive = true


func _on_Accept_pressed():
	get_node("Tutorial").visible = false
	animationPlayer.play("PortalOut")
