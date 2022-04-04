if global.panic
{
	var xx = 0, w = room_width, yy = 0;
	if room == custom_lvl_room
	{
		xx = _camx;
		yy = _camy;
		w = _camw;
		
		with obj_camera
		{
			if bound_camera && instance_exists(player)
			{
				xx = player.cam.x;
				yy = player.cam.y;
				w = player.cam_width;
			}
		}
	}
	
	repeat min(round(w / 960), 8)
		instance_create(irandom_range(xx, w), yy + 10, obj_debris);
	alarm[0] = 5;
}

