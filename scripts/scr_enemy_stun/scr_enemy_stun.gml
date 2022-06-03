function scr_enemy_stun()
{
	if object_index == obj_ninja
		attack = true
	
	// april build bullshit
	switch hp
	{
		case -1: grav = 1.1; break;
		case -2: grav = 1.3; break;
	}
	
	if grounded
	{
		if global.gameplay == 0
		{
			stunned--;
			if object_index == obj_peasanto && angry != 1
				stunned -= 4;
		}
		else
		{
			switch global.stylethreshold
			{
				case 0:
					stunned -= 1
					break
				case 1:
					stunned -= 1.35
					break
				case 2:
					stunned -= 1.65
					break
				case 3:
					stunned -= 2
					break
			}
		}
	}

	if stuntouchbuffer > 0
		stuntouchbuffer--
	
	if sprite_index != spr_tank_hitwall
		sprite_index = stunfallspr
	else if floor(image_index) >= image_number - 1 && sprite_index == spr_tank_hitwall && global.gameplay != 0
	{
		state = states.walk
		stunned = 0
		sprite_index = spr_tank_walk
	}
	
	image_speed = 0.35
	if grounded && vsp >= 0
	{
		if thrown && hp <= 0 && object_index != obj_pizzaballOLD
			instance_destroy();
		else
			hsp = 0;
		
		thrown = false
		thrown_vertically = false
		grav = 0.5
	}
	
	var railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then hsp = railmeet.spdh;
	
	var xx = sign(hsp);
	if thrown && hp <= 0 && !thrown_vertically
		xx = -image_xscale;
	
	if scr_solid(x + xx, y) && !place_meeting(x + xx, y, obj_destructibles)
	{
		with instance_create(x, y, obj_bulletimpact)
			image_xscale = -other.image_xscale
		
		if thrown && hp <= 0 && object_index != obj_pizzaballOLD
			instance_destroy();
		else
			image_xscale *= -1;
		
		hsp = -image_xscale * 4;
		grav = 0.5;
	}
	
	if stunned <= 0 && (object_index != obj_peasanto or angry or global.gameplay != 0)
	&& ((floor(image_index) >= image_number - 1 && grounded) or global.gameplay == 0)
	{
		if object_index != obj_miniufo && object_index != obj_ancho && object_index != obj_pizzaboy
		&& (global.gameplay == 0 or object_index == obj_babybear)
		{
			vsp = -4
			grav = 0.5
		}
		else
			vsp = 0
		
		image_index = 0
		
		sprite_index = walkspr
		state = states.walk
		
		if object_index == obj_banditochicken && !activated
			sprite_index = spr_banditochicken_sleep
	}
	
	var railmeet = instance_place(x, y + 1, obj_railparent);
	if railmeet then hsp = railmeet.spdh;
}