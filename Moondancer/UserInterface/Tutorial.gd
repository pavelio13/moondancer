extends Control


func _on_Accept_pressed():
	visible = false
	get_parent().animationPlayer.play("PortalOut")
