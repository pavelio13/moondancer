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
		get_node("AnimatedSprite").play("tierraEncendido")
		get_parent().get_node("Templo/colPlanta_apagada").visible = false
		get_parent().get_node("Templo/colPlanta_encendida").visible = true
	elif name == "SpawnWater":
		Stats.waterButton = true
		get_node("AnimatedSprite").play("aguaEncendido")
		get_parent().get_node("Templo/colAgua_apagada").visible = false
		get_parent().get_node("Templo/colAgua_encendida").visible = true
	elif name == "SpawnFire":
		Stats.fireButton = true
		get_node("AnimatedSprite").play("fuegoEncendido")
		get_parent().get_node("Templo/colFuego_apagada").visible = false
		get_parent().get_node("Templo/colFuego_encendida").visible = true
	elif name == "SpawnAir":
		Stats.airButton = true
		get_node("AnimatedSprite").play("aireEncendido")
		get_parent().get_node("Templo/colAire_apagada").visible = false
		get_parent().get_node("Templo/colAire_encendida").visible = true
	else:
		print("Error")
	
	get_node("Light2D").enabled = true
	get_node ("CollisionShape2D").queue_free()
	body.state = 7
	
