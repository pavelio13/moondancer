extends Node

var spawnpoint = Vector2.ZERO
var direction = 1
var earthButton = false
var waterButton = false
var fireButton = false
var airButton = false

func _on_SpawnEarth_body_entered(body):
	Stats.spawnpoint = body.global_position
	Stats.direction = body.direction
	
	if name == "SpawnEarth":
		Stats.earthButton = true
		get_node("AnimatedSprite").play("default")
	elif name == "SpawnWater":
		Stats.waterButton = true
		get_node("AnimatedSprite").play("aguaEncendido")
	elif name == "SpawnFire":
		Stats.fireButton = true
		get_node("AnimatedSprite").play("fuegoEncendido")
	elif name == "SpawnAir":
		Stats.airButton = true
		get_node("AnimatedSprite").play("aireEncendido")
	else:
		print("Error")
	
	get_node("Light2D").enabled = true
	get_node ("CollisionShape2D").set_deferred("disabled", true)
	body.state = 7
	
