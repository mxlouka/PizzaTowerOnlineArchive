with other
{
	if state != states.rocket && character != "V"
	{
		other.playerid = id
		
		xscale = other.image_xscale
		state = states.rocket
		tv_push_prompt_once(tv_create_prompt("This is the rocket transformation text", 2, spr_tv_rocket, 3), "rocket")
		sprite_index = spr_rocketstart
		image_index = 0
		
		if movespeed < 14
			movespeed = 14
		
		x = other.x
		y = other.y - 18
		if sprite_index == spr_playerN_rocketstart
			y += 4
	}
}

