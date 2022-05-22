var player = instance_place(x, y, obj_player);
if layer_exists(mylayer)
{
	if player
	{
		if !oneway
		{
			if ds_list_find_index(global.saveroom, id) == -1
			{
				if !done
				{
					audio_stop_sound(sfx_collectgiantpizza);
					audio_stop_sound(sfx_secretwall);
					scr_soundeffect(sfx_secretwall);
				}
				ds_list_add(global.saveroom, id);
			}
			alpha = Approach(alpha, 0, 0.1);
		}
	}
	else if alpha < 1
	{
		alpha = Approach(alpha, 1, 0.1);
		if alpha >= 1 && oneway
		{
			with instance_create(x, y, obj_solid)
			{
				image_xscale = other.image_xscale;
				image_yscale = other.image_yscale;
			}
		}
	}
}

