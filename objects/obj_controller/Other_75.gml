if async_load[? "event_type"] == "gamepad discovered"
{
	var ind = async_load[? "pad_index"];
	if global.cont != ind
	{
		if global.coop && global.cont2 == -1 && global.cont != -1
		{
			with obj_roomname
			{
				message = "PLAYER 2 GAMEPAD " + string(ind);
				showtext = true;
				alarm[0] = room_speed;
			}
			global.cont2 = ind;
		}
		else if global.coop && global.cont2 != -1 && global.cont != -1
			ds_list_add(othergamepad, global.cont);
		else
		{
			if connected
				ds_list_add(othergamepad, global.cont);
			
			with obj_roomname
			{
				message = "USING GAMEPAD " + string(ind);
				if global.coop
					message = "PLAYER 1 GAMEPAD " + string(ind);
				showtext = true;
				alarm[0] = room_speed;
			}
		
			global.cont = ind;
		}
		
		connected = true;
		scr_soundeffect(sfx_contin);
	}
}
if async_load[? "event_type"] == "gamepad lost"
{
	var pad = async_load[? "pad_index"];
	var size = ds_list_size(othergamepad) - 1;
	
	if size > -1
	{
		if global.cont == pad && !global.coop
		{
			var ind = ds_list_find_value(othergamepad, size);
			ds_list_delete(othergamepad, size);
			
			with obj_roomname
			{
				message = "USING GAMEPAD " + string(ind);
				showtext = true;
				alarm[0] = room_speed;
			}
			
			global.cont = ind;
		}
		else
			ds_list_delete(othergamepad, ds_list_find_index(othergamepad, pad));
	}
	else
	{
		if global.cont2 == pad
		{
			with obj_roomname
			{
				message = "PLAYER 2 GAMEPAD OUT";
				showtext = true;
				alarm[0] = room_speed;
			}
		}
		else
		{
			with obj_roomname
			{
				message = "GAMEPAD " + string(pad) + " OUT";
				if global.coop
					message = "PLAYER 1 GAMEPAD OUT";
				showtext = true;
				alarm[0] = room_speed;
			}
		
			global.cont = -1;
		}
		if global.cont == -1 && global.cont2 == -1
			connected = false;
	}
	scr_soundeffect(sfx_contout);
}

