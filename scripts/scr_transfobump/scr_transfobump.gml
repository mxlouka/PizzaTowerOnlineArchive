function scr_transfobump(_setstate = true)
{
	if state == states.cotton
	{
		// cotton
		scr_soundeffect(sfx_hitenemy);
		instance_create(x, y, obj_genericpoofeffect);
		
		if _setstate
		{
			alarm[5] = 2;
			alarm[7] = 60;
			state = states.normal;
		}
	}
	else if state == states.bombpep && sprite_index != spr_bombpepend
	{
		scr_soundeffect(sfx_bombpep2);
		instance_create(x, y, obj_bombexplosion);
		
		if _setstate
			sprite_index = spr_bombpepend;
	}
	else if (state == states.knightpep or state == states.knightpepattack or state == states.knightpepslopes)
	&& sprite_index != spr_knightpepstart
	{
		// knight armor debris
		if character == "P" or character == "N" or character == "SP" or character == "PP"
		{
			var debrisspr = spr_knightdebris;
			switch character
			{
				case "N": sprite_index = spr_playerN_knightarmor; break;
				case "SP": sprite_index = spr_knightdebrisSP; break;
			}
		
			for(var i = 0; i < sprite_get_number(debrisspr); i++)
			{
				with instance_create(x, y, obj_knightdebris)
				{
					image_index = i;
					sprite_index = debrisspr;
				}
			}
		}
		else repeat 6
			instance_create(x, y, obj_metaldebris);
		scr_soundeffect(sfx_loseknight);
	
		// bump
		if _setstate
		{
			scr_soundeffect(sfx_bumpwall);
			hsp = 5 * -xscale;
			vsp = -3;
			image_index = 0;
			flash = true;
			state = states.bump;
			
			alarm[5] = 2;
			alarm[7] = 60;
			hurted = true;
		}
		return true;
	}
	else
		return false;
}