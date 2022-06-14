if ds_list_find_index(global.saveroom, id) = -1
{
	if place_meeting(x, y, obj_tiles)
		scr_secretdebris();
	else
	{
		var rep = global.gameplay == 0 ? 4 : 2; // amount of debris
		repeat rep
		{
			with instance_create(x + irandom(sprite_width), y + irandom(sprite_height), obj_debris)
			{
				image_xscale = abs(other.image_xscale);
				image_yscale = abs(other.image_yscale);
				
				if other.sprite_index == spr_destroyable_ss
					sprite_index = spr_debris_ss;
				
				momentum = other.momentum;
				
				if other.sprite_index == spr_towerblocksmall
				{
					image_speed = 0.35
					sprite_index = spr_towerblockdebris
				}
			}
		}
	}
	if global.gameplay != 0
	{
		scr_sleep(5)
		with instance_create(x + irandom(sprite_width), y + irandom(sprite_height), obj_parryeffect)
	    {
	        sprite_index = spr_deadjohnsmoke
	        image_speed = 0.35
	    }
	}
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)
	ds_list_add(global.saveroom, id)
}

