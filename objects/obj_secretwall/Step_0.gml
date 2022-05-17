var player = instance_place(x, y, obj_player);
if layer_exists(mylayer)
{
	if player
	{
		if ds_list_find_index(global.saveroom, id) == -1
		{
			scr_soundeffect(sfx_secretwall);
			ds_list_add(global.saveroom, id);
		}
		alpha = Approach(alpha, 0, 0.1);
	}
	else
		alpha = Approach(alpha, 1, 0.1);
}

