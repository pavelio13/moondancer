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
		
		$Tutorial/Panel/RichTextLabel.bbcode_text = earth_text
		$Tutorial/Panel/AnimatedSprite.play("earthTutorial")
		$Tutorial/Panel/TextureRect.texture = load("res://Assets/UI/Buttons/botonPlanta.png")
		get_node("Tutorial/Panel").visible = true
		
#		get_parent().get_node("Templo/colPlanta_apagada").visible = false
#		get_parent().get_node("Templo/colPlanta_encendida").visible = true
		
	elif name == "SpawnWater":
		Stats.waterButton = true
		get_node("AnimatedSprite").play("aguaEncendido")
		
		$Tutorial/Panel/RichTextLabel.bbcode_text = water_text
		$Tutorial/Panel/AnimatedSprite.play("waterTutorial")
		$Tutorial/Panel/TextureRect.texture = load("res://Assets/UI/Buttons/botonAgua.png")
		get_node("Tutorial/Panel").visible = true
		
#		get_parent().get_node("Templo/colAgua_apagada").visible = false
#		get_parent().get_node("Templo/colAgua_encendida").visible = true
	
	elif name == "SpawnFire":
		Stats.fireButton = true
		get_node("AnimatedSprite").play("fuegoEncendido")
		
		$Tutorial/Panel/RichTextLabel.bbcode_text = fire_text
		$Tutorial/Panel/AnimatedSprite.play("fireTutorial")
		$Tutorial/Panel/TextureRect.texture = load("res://Assets/UI/Buttons/botonFuego.png")
		get_node("Tutorial/Panel").visible = true
		
#		get_parent().get_node("Templo/colFuego_apagada").visible = false
#		get_parent().get_node("Templo/colFuego_encendida").visible = true
	
	elif name == "SpawnAir":
		Stats.airButton = true
		get_node("AnimatedSprite").play("aireEncendido")
		
		$Tutorial/Panel/RichTextLabel.bbcode_text = air_text
		$Tutorial/Panel/AnimatedSprite.play("airTutorial")
		$Tutorial/Panel/TextureRect.texture = load("res://Assets/UI/Buttons/botonAire.png")
		get_node("Tutorial/Panel").visible = true
		
#		get_parent().get_node("Templo/colAire_apagada").visible = false
#		get_parent().get_node("Templo/colAire_encendida").visible = true
	
	else:
		print("Error")
	
	get_node("Light2D").enabled = true
	get_node ("CollisionShape2D").queue_free()
	body.state = 7
	
	
func _on_Accept_pressed():
	$Tutorial/Panel.visible = false
	get_parent().get_node("Player").animationPlayer.play("PortalOut")


var earth_text = "[color=#29c06b]¡PODER DE TIERRA OBTENIDO!\n\nAhora Noom tendrá la habilidad de saltar gracias al impulso de las semillas del árbol.\n\nPodrás atravesar algunas piedras mágicas (señalizadas con el símbolo) y saltar más alto si pulsas el botón durante más tiempo.[/color]"

var water_text = "[color=#8eabc0]¡PODER DE AGUA OBTENIDO!\n\nAhora Noom tendrá la habilidad de saltar gracias al impulso de las semillas del árbol.\n\nPodrás atravesar algunas piedras mágicas (señalizadas con el símbolo) y saltar más alto si pulsas el botón durante más tiempo.[/color]"

var fire_text = "[color=#c75f47]¡PODER DE FUEGO OBTENIDO!\n\nAhora Noom tendrá la habilidad de saltar gracias al impulso de las semillas del árbol.\n\nPodrás atravesar algunas piedras mágicas (señalizadas con el símbolo) y saltar más alto si pulsas el botón durante más tiempo.[/color]"

var air_text = "[color=#cbc959]¡PODER DE AIRE OBTENIDO!\n\nAhora Noom tendrá la habilidad de saltar gracias al impulso de las semillas del árbol.\n\nPodrás atravesar algunas piedras mágicas (señalizadas con el símbolo) y saltar más alto si pulsas el botón durante más tiempo.[/color]"
