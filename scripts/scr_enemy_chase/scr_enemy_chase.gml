function scr_enemy_chase()
{
	if object_index == obj_minijohn or object_index == obj_banditochicken or object_index == obj_charcherry
	{
		//Identify the player
		var targetplayer = obj_player
	
		//Face the player
		if x != targetplayer.x && !(image_xscale == -sign(x - targetplayer.x))
		{
			movespeed = 4;
			if global.gameplay == 0
				movespeed = 7;
			if object_index == obj_charcherry
				movespeed = 10;
			
			image_xscale = -sign(x - targetplayer.x);
			momentum = -image_xscale * (movespeed + 4);
		}
		
		hsp = image_xscale * movespeed + momentum
		var railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then hsp += railmeet.spdh;
		
		// jump
		if object_index == obj_charcherry
		{
			if grounded && scr_solid(x + image_xscale, y - 4, false)
				vsp = -8;
		}
		
		//Slow down
		if abs(momentum) > 0
			momentum = max(abs(momentum) - 0.1, 0) * sign(momentum);
		
		//Effect
		if grounded
			steppy--;
		if steppy <= 0
		{
			instance_create(x, y + 43, obj_cloudeffect);
			steppy = 20;
		}
	}
}
