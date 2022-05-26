if ds_list_find_index(global.saveroom, id) = -1
{
	if place_meeting(x, y, obj_tiles)
		scr_secretdebris();
	else
	{
		var rep = global.gameplay == 0 ? 4 : 2; // amount of debris
		repeat rep
		{
			with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
			{
				image_xscale = abs(other.image_xscale);
				image_yscale = abs(other.image_yscale);
			
				if other.sprite_index == spr_destroyable_NEW
					sprite_index = spr_debris_NEW;
				else if other.sprite_index == spr_destroyable_ss
					sprite_index = spr_debris_ss;
			
				momentum = other.momentum;
			}
		}
	}
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)
	ds_list_add(global.saveroom, id)
}

