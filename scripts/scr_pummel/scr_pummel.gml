function scr_pummel(setspeed = true)
{
	sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4);
	image_index = 0;
	state = states.tackle;
	
	if setspeed
	{
		movespeed = 3;
		vsp = -3;
	}
}
