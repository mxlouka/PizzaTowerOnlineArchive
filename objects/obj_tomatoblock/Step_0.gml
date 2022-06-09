//Tomato block 
with obj_player
{
	if place_meeting(x, y + 1, other) && state != states.gameover
	{
		endtumble = true;
		fallinganimation = 0;
		if key_jump2 && (scr_stylecheck(0, 2) or string_startswith(room_get_name(room), "oldsewer"))
		{
			vsp = -20;
			if state == states.jump && character == "P"
				sprite_index = spr_player_Sjump;
		}
		else
			vsp = -11;
		suplexmove = false;
		
		if state == states.cheeseball
			jumpstop = true;
		
		with other
		{
			image_index = 0;
			image_speed = 0.35;
		}
	}
}

with obj_baddie
{
	if place_meeting(x, y + 1, other) && state != states.grabbed && hp > 0
	{
		thrown = false;
		vsp = -11;
		
		with other
		{
			image_index = 0;
			image_speed = 0.35;
		}
	}
}

with obj_antonball
{
	if place_meeting(x, y + 1, other)
	{
		vsp = -8;
		
		with other
		{
			image_index = 0;
			image_speed = 0.35;
		}
	}
}