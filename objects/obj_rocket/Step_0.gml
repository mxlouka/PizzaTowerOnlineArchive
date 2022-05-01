if instance_exists(playerid) && playerid.state == states.rocket
	image_alpha = 0
else
	image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1

