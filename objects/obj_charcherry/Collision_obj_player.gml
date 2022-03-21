if state == states.chase
{
	instance_destroy();
	
	with other
	{
		if instance_exists(parry_inst)
		{
			with parry_inst
				event_user(0);
		}
		else
		{
			scr_knightbump(true, false);
			
			image_index = 0;
			vsp = -4;
			sprite_index = spr_bombpepend;
		
			state = states.bombpep;
			bombpeptimer = 0;
		}
	}
}
