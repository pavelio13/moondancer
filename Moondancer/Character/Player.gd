class_name Player
extends Actor


const FLOOR_DETECT_DISTANCE = 20.0

export(String) var action_suffix = ""

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer


func _physics_process(_delta):
	var direction = get_direction()

	var is_jump_interrupted = Input.is_action_just_released("ui_up" + action_suffix) and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)

	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO

	if direction.x != 0:
		sprite.scale.x = 1 if direction.x > 0 else -1
		
	var animation = get_new_animation()
	if animation != animation_player.current_animation:
		animation_player.play(animation)



func get_direction():
	return Vector2(
		Input.get_action_strength("ui_right" + action_suffix) - Input.get_action_strength("ui_left" + action_suffix),
		-1 if is_on_floor() and Input.is_action_just_pressed("ui_up" + action_suffix) else 0
	)


# This function calculates a new velocity whenever you need it.
# It allows you to interrupt jumps.
func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	var velocity = linear_velocity
	
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity


func get_new_animation():
	var animation_new = "Walk"
	if is_on_floor():
		animation_new = "Walk"
#	else:
#		animation_new = "falling" if _velocity.y > 0 else "jumping"
	return animation_new
