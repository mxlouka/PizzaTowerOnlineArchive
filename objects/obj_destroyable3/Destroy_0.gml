if ds_list_find_index(global.saveroom, id) = -1
{
	var rep = global.gameplay == 0 ? 7 : 8;
	for(var i = 0; i <= rep; i++)
	{
		if global.gameplay == 0
		{
			var xx = sprite_width / 2;
			var yy = sprite_height / 2;
		}
		else
		{
			xx = random(sprite_width / 2) + sprite_width / 4;
			yy = random(sprite_height / 2) + sprite_height / 4;
		}
		with instance_create(x + xx, y + yy, obj_debris)
		{
			image_xscale = abs(other.image_xscale);
			image_yscale = abs(other.image_yscale);
			
			if other.sprite_index == spr_bigdestroyable_ss
				sprite_index = spr_bigdebris_ss;
			else if other.sprite_index == spr_bigdestroyable_NEW
				sprite_index = spr_debris_NEW;
			else
				sprite_index = spr_bigdebris;
			
			momentum = other.momentum;
		}
	}
	audio_stop_sound(sfx_breakblock1)
	audio_stop_sound(sfx_breakblock2)
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)
	ds_list_add(global.saveroom, id) 
	
	/*
	var roomname = room_get_name(room)
	if string_letters(roomname) != "PProom" && room != custom_lvl_room && check_online()
	{
		var pizzacoin = irandom_range(0, 25)
		if pizzacoin == 5
			with instance_create(x + 16, y + 16, obj_pizzacoin)
				hsp = choose(-2, 2)
	}
	*/
}

