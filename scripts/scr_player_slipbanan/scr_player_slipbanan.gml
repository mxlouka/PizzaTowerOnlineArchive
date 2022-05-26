function scr_player_slipbanan()
{
	var sugary = false;
	if check_sugary()
		sugary = true;
	
	hsp = xscale * movespeed;
	if scr_solidwall(x + xscale, y) && ((!place_meeting(x + hsp + xscale, y, obj_destructibles) && !place_meeting(x + hsp + xscale, y, obj_metalblock)) or character == "V")
	{
		if sugary
		{
			scr_soundeffect(sfx_bumpwall);
			instance_create(x, y, obj_bangeffect);
			xscale *= -1;
			sprite_index = spr_rockethitwall;
		}
		else
			movespeed = 0;
	}
	
	if sprite_index == spr_slipbanan1
	{
		if floor(image_index) >= image_number - 1
			image_speed = 0;
		else
			image_speed = 0.35;
	}
	else
		image_speed = 0.35;
	
	if sprite_index == spr_slipbanan2
	{
		if sugary
		{
			if !grounded
				sprite_index = spr_rockethitwall;
			
			var slop = instance_place(x, y + 2, obj_slope);
			if slop && slop.image_xscale != 0
			{
				if xscale != -sign(slop.image_xscale)
				{
					movespeed -= 0.25;
					if movespeed <= 0
					{
						xscale = -sign(slop.image_xscale);
						movespeed = 0;
					}
				}
				else if movespeed < 12
					movespeed += 0.25;
			}
			else
			{
				movespeed = Approach(movespeed, 0, 0.5);
				if movespeed <= 0
					state = states.normal;
			}
		}
		
		if floor(image_index) >= image_number - 1
		{
			if sugary
				image_speed = 0;
			else
				state = states.normal;
		}
	}
	else if scr_solid(x, y + 1) && vsp >= 0 && ((!place_meeting(x, y + vsp, obj_destructibles) && !place_meeting(x, y + vsp, obj_metalblock)) or character == "V")
	{
		if sugary && sprite_index != spr_rockethitwall
		{
			instance_create(x, y, obj_bangeffect);
			vsp = -10;
			sprite_index = spr_rockethitwall;
		}
		else
		{
			scr_soundeffect(sfx_step);
			instance_create(x, y, obj_landcloud);
			
			sprite_index = spr_slipbanan2;
			image_index = 0;
			image_speed = 0.35;
			
			if !sugary
				movespeed = 0;
		}
	}
}

