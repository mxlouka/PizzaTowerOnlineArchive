image_alpha -= 0.15
if image_alpha <= 0
	instance_destroy()
if instance_exists(playerid)
	visible = playerid.visible
