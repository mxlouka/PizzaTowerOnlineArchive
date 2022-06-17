if room == rm_editor exit;
if ds_list_find_index(global.saveroom, id) == -1
{
	if sprite_index == spr_onewaybigblock_NEW
	{
		with instance_create(x + sprite_width / 2, x + sprite_height / 2, obj_sausageman_dead)
	        sprite_index = spr_bigdoughblockdead
	}
	else
	{
		repeat 6 with instance_create(x + sprite_width / (4 / 3), y + sprite_height / 2, obj_debris)
		{
			image_xscale = abs(other.image_xscale)
			image_yscale = abs(other.image_yscale)
		
			if other.sprite_index == spr_onewayblock_ss
				sprite_index = spr_bigdebris_ss;
			else
				sprite_index = spr_bigdebris;
		
			momentum = other.momentum;
		}
		if sprite_index == spr_onewayblock_ss
		{
			with instance_create(x + sprite_width / (4 / 3), y + sprite_height / 2, obj_debris)
			{
				sprite_index = spr_bigdebrisbandage_ss;
				momentum = other.momentum;
			}
		}
	}
	
	if audio_is_playing(sfx_breakblock1) or audio_is_playing(sfx_breakblock2)
	{
		audio_stop_sound(sfx_breakblock1)
		audio_stop_sound(sfx_breakblock2)
	}
	scr_soundeffect(sfx_breakblock1, sfx_breakblock2)
	ds_list_add(global.saveroom, id)
}
with mysolid
	instance_destroy()
