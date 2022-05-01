trigger = true;
active = false;

func = function()
{
	if place_meeting(x, y, obj_player)
	{
		with obj_eventtrigger
			active = false;
		active = true;
	}
	
	if active
	{
		with obj_camera
			angle = round(lerp(angle, 0, 0.25));
		with obj_camera
			zoom = lerp(zoom, 1, 0.25);
	}
}

