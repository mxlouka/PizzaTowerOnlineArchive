function scr_player_cotton()
{
	image_speed = 0.35;
	
	// move
    if sprite_index != spr_cotton_slam
        move = key_left + key_right;
	
	var drilling = sprite_index == spr_cotton_drill;
	if move != 0
	{
		if dir != xscale
	    {
	        dir = xscale;
	        movespeed = 0;
	    }
        xscale = move;
	}
	
	if drilling
		hsp = move;
	else if move != 0
	{
		var maxspeed = 6;
		var acc = 0.5;
		if key_attack && grounded
		{
			maxspeed = 10;
			acc = 0.25;
		}
		
		if movespeed < maxspeed or grounded
			movespeed = Approach(movespeed, maxspeed, acc);
		hsp = move * movespeed;
	}
	else
		movespeed = 0;
	
    if vsp > 5 && !drilling
        vsp = 5;
	
	// jump
    if key_jump && grounded && !drilling
    {
        vsp = -14;
	    image_index = 0
	    sprite_index = spr_cotton_jump
        instance_create(x, y, obj_highjumpcloud2)
        scr_soundeffect(sfx_cottonjump)
    }
	
	// attack
    if key_slap2 && sprite_index != spr_cotton_attack && !suplexmove
    {
		suplexmove = true
		jumpstop = true
        flash = true
        image_index = 0
        sprite_index = spr_cotton_attack
		if global.gameplay == 0 or !grounded
		{
			vsp = -4
			grounded = false
		}
        scr_soundeffect(sfx_cottonattack)
    }
	
	//Jump Stop
	if !key_jump2 && !jumpstop && vsp < 0.5
	{
		vsp /= 2;
		jumpstop = true;
	}
	if grounded
		jumpstop = false;
	
	// attack
    if sprite_index == spr_cotton_attack
    {
        movespeed = 8
		hsp = movespeed * xscale
        move = xscale
		
		if grounded && global.gameplay == 0
	    {
			scr_soundeffect(sfx_step);
			instance_create(x, y, obj_landcloud);
			
	        image_index = 0
			if move == 0
				sprite_index = spr_cotton_land;
			else
				sprite_index = spr_cotton_walk;
		}
		if image_index >= image_number - 1 && global.gameplay != 0
			sprite_index = spr_cotton_idle;
    }
	
	// animation
    if sprite_index == spr_cotton_idle && move != 0
    {
        image_index = 0
        sprite_index = spr_cotton_walk
    }
    if sprite_index == spr_cotton_walk
    {
		image_speed = 0.35 * movespeed / 4;
		if move == 0
		{
	        image_index = 0
	        sprite_index = spr_cotton_idle
		}
    }
	
	if floor(image_index) >= image_number - 1
	{
		if sprite_index == spr_cotton_jump
	    {
	        image_index = 0;
	        sprite_index = spr_cotton_fall;
	    }
	    if sprite_index == spr_cotton_doublejump
	    {
	        image_index = 0;
	        sprite_index = spr_cotton_doublefall;
	    }
	    if sprite_index == spr_cotton_slam
	    {
	        image_index = 0;
	        sprite_index = spr_cotton_idle;
	    }
		if sprite_index == spr_cotton_land
		{
			image_index = 0;
			sprite_index = spr_cotton_idle;
		}
	}
	
	// land
    if (sprite_index == spr_cotton_fall or sprite_index == spr_cotton_doublefall or sprite_index == spr_cotton_jump or sprite_index == spr_cotton_doublejump) && (grounded && vsp >= 0)
    {
        image_index = 0
        sprite_index = spr_cotton_land
        instance_create(x, y, obj_landcloud)
        scr_soundeffect(sfx_step)
    }
	
	// double jump
    if !grounded && (sprite_index == spr_cotton_fall or sprite_index == spr_cotton_jump) && key_jump && vsp > 0
    {
		jumpstop = false
        vsp = -10
        image_index = 0
        sprite_index = spr_cotton_doublejump
        with instance_create(x, y, obj_highjumpcloud2)
			sprite_index = spr_cottonpoof;
        scr_soundeffect(sfx_cottondoublejump)
    }
	
	// drill move
    if key_down2 && !grounded && !drilling && sprite_index != spr_cotton_slam
    {
        vsp = 9
        sprite_index = spr_cotton_drill
        image_index = 0
        scr_soundeffect(sfx_suplexdashSP)
        flash = true
		
		with instance_create(x, y, obj_mach3effect)
		{
			hspeed = -7;
			playerid = other.object_index;
		}
		with instance_create(x, y, obj_mach3effect)
		{
			hspeed = 7;
			playerid = other.object_index;
		}
		with instance_create(x, y, obj_mach3effect)
		{
			vspeed = -7;
			playerid = other.object_index;
		}
		with instance_create(x, y, obj_mach3effect)
		{
			vspeed = 7;
			playerid = other.object_index;
		}
		
		with obj_mach3effect
		{
			if playerid == other.object_index
			{
				image_index = other.image_index - 1;
				image_xscale = other.xscale;
				sprite_index = other.sprite_index;
				keep = true;
			}
		}
    }
	
	// fall off
    if !grounded && sprite_index != spr_cotton_jump && sprite_index != spr_cotton_attack && sprite_index != spr_cotton_doublejump && sprite_index != spr_cotton_doublefall && sprite_index != spr_cotton_drill && sprite_index != spr_cotton_slam
        sprite_index = spr_cotton_fall
	
    if sprite_index == spr_cotton_slam
    {
        movespeed = 0
        hsp = 0
        move = 0
        dir = 0
    }
	
	// land while drilling
	if drilling && grounded && !place_meeting(x, y + 1, obj_cottonblock) && !place_meeting(x, y + 1, obj_destructibles)
	{
		instance_create(x, y, obj_landcloud)
		scr_soundeffect(sfx_step)
		
	    sprite_index = spr_cotton_land
	    vsp = 0
	    movespeed = 0
	    image_index = 0
	}
	
	// walking cloud
	if sprite_index == spr_cotton_walk
	{
		var step1 = 10;
		var step2 = 21;
		if floor(image_index) == step1 or floor(image_index) == step2
		{
			if !steppy
			{
				instance_create(x, y + 43, obj_cloudeffect)
				steppy = true
			}
		}
		else
			steppy = false;
	}
}

