extends CanvasLayer


func _on_Accept_pressed():
	$Panel.visible = false
	get_parent().animationPlayer.play("PortalOut")
