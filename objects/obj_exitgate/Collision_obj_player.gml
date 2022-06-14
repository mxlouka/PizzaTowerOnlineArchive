//Begin cutscene
with other
{
	if !global.panic && other.visible && ds_list_find_index(global.saveroom, other.id) == -1
	&& state == states.comingoutdoor
	{
		xscale = 1;
		var slam = (floor(image_index) == image_number - 2);
		
		// sugary bullshit
		if other.sprite_index == spr_exitgate_ss
		{
			slam = false;
			if floor(image_index) >= image_number - 5
			{
				other.image_index = 0;
				other.sprite_index = spr_exitgateclosing_ss;
				other.image_speed = 0.35;
			}
		}
		if other.sprite_index == spr_exitgateclosing_ss
		{
			slam = false;
			if floor(other.image_index) >= 3
				slam = true;
		}
			
		if slam
		{
			gp_vibration(1, 1, 0.9);
			scr_soundeffect(sfx_groundpound);
			sprite_index = spr_Timesup;
			image_index = 0;
			
			with obj_camera
			{
				shake_mag = 10;
				shake_mag_acc = 30 / room_speed;
			}
			
			if other.sprite_index != spr_exitgateclosing_ss
				other.image_index = 0;
			ds_list_add(global.saveroom, other.id);
		}
	}
	
	if grounded && x > other.x - 160 && x < other.x + 160 && key_up2
	&& (state == states.normal or state == states.mach1 or state == states.mach2 or state == states.mach3)
	&& (global.panic or global.snickchallenge) && !global.failedmod
	{
		state = states.door;
		doorx = other.x;
		sprite_index = spr_lookdoor;
		image_index = 0;
		
		if !instance_exists(obj_endlevelfade)
			instance_create(x, y, obj_endlevelfade);
		
		if global.combo > 0
        {
            global.combotime = 0
            global.combo = 0
            obj_camera.alarm[4] = -1
            for (var i = 0; i < global.comboscore; i += 10)
				create_collect(other.x + irandom_range(-60, 60), other.y - 100 + irandom_range(-60, 60), scr_collectsprite())
            global.comboscore = 0
        }
	}
}
