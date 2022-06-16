function scr_player_dosuplexdash()
{
	grav = basegrav;
	
	suplexmove = true
	if character != "SP" or global.gameplay != 0
		suplexdashsnd =	scr_soundeffect(sfx_suplexdash);
	else
		scr_soundeffect(sfx_suplexdashSP);
			
	if !(character == "SP" && state == states.jump && vsp < 0)
	{
		state = states.handstandjump
		image_index = 0
		
		if !grounded && character != "SP"
			sprite_index = spr_suplexdashjumpstart
		else if !shotgunAnim
			sprite_index = spr_suplexdash
		else
			sprite_index = spr_shotgunsuplexdash
		
		if global.gameplay != 0
		{
			if movespeed < 5
				movespeed = 5;
			flash = true;
		}
		else
		{
			if character != "SP" && !grounded
				vsp = -4
			
			if character != "N"
				movespeed = 6
			else
				movespeed = 4
		}
		
		if scr_stylecheck(2)
		{
			if grounded
			{
				with instance_create(x, y, obj_crazyrunothereffect)
					image_xscale = other.xscale;
			}
			with instance_create(x + (xscale * -50), y, obj_superdashcloud)
				image_xscale = other.xscale;
		}
	}
	else
	{
		input_buffer_jump = 0
		movespeed = 10
		instance_create(x, y, obj_jumpdust)
		state = states.mach2
		vsp = -11
	}
}