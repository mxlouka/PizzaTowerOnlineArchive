if ds_list_find_index(global.saveroom, id) == -1
{
	var shit = global.gameplay == 0 ? 4 : 8;
	if sprite_index == spr_metalblock_ss
		shit = 8;
	
	repeat shit with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_metaldebris)
	{
		if other.sprite_index == spr_metalblock_ss
		{
			sprite_index = spr_metaldebris_ss;
			image_index = random_range(0, 7);
			//hsp = random_range(-8, 8);
		}
		else if other.sprite_index == spr_metalbescape
			sprite_index = spr_metalblockdebrisescape;
		else if other.sprite_index == spr_metalbescape_NEW
			sprite_index = spr_metalblockdebrisescape_NEW;
		else if other.sprite_index == spr_hotmetalblock
			sprite_index = spr_metalblockharddebris;
		else if other.sprite_index == spr_metalb_NEW
			sprite_index = spr_metalblockdebris_NEW;
		
		momentum = other.momentum;
	}
	
	with obj_camera
	{
	    shake_mag = 20;
	    shake_mag_acc = 40 / room_speed;
	}
	
	scr_soundeffect(sfx_breakmetal)
	ds_list_add(global.saveroom, id) 
}
