extends Node

var spawnpoint = Vector2.ZERO
var direction = 1

func _on_SpawnEarth_body_entered(body):
	Stats.spawnpoint = body.global_position
	Stats.direction = body.direction
