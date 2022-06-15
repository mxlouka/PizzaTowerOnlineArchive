function scr_player_tumble()
{
	if global.gameplay != 0
	{
		var railh = 0, railmeet = instance_place(x, y + 1, obj_railparent);
		if railmeet then railh = railmeet.spdh;
	    hsp = xscale * movespeed + railh;
		
	    move = key_right + key_left
	    mask_index = spr_crouchmask
	    if sprite_index == spr_tumblestart
	        movespeed = 6
	    if ((!grounded) && (sprite_index == spr_machroll or sprite_index == spr_mach2jump or sprite_index == spr_player_backslide or sprite_index == spr_player_backslideland))
	    {
	        vsp = 10
	        sprite_index = spr_dive
	    }
	    if (grounded && sprite_index == spr_dive)
	    {
	        sprite_index = spr_machroll
	        image_index = 0
	    }
	    if (grounded && sprite_index != spr_tumble)
	        movespeed -= 0.05
	    if (sprite_index == spr_dive && key_jump)
	    {
	        sprite_index = spr_player_poundcancel1
	        image_index = 0
	        state = states.freefall
	        vsp = -6
	    }
	    if (movespeed <= 2 && sprite_index != spr_player_breakdance)
	        state = states.normal
		
	    if (!scr_slope() && sprite_index == spr_tumblestart && floor(image_index) < 11)
	        image_index = 11
		
	    if (sprite_index == spr_mach2jump && grounded)
	    {
	        image_index = 0
	        sprite_index = spr_machroll
	    }
	    if (sprite_index == spr_mach2jump && grounded)
	    {
	        image_index = 0
	        sprite_index = spr_machroll
	    }
	    if (sprite_index == spr_crouchslip && (!grounded))
	        sprite_index = spr_player_jumpdive2
	    if (sprite_index == spr_player_Sjumpcancelland && floor(image_index) == (image_number - 1))
	        sprite_index = spr_player_Sjumpcancelslide
	    if (sprite_index == spr_player_jumpdive2 && grounded)
	        sprite_index = spr_crouchslip
	    if (floor(image_index) == (image_number - 1) && sprite_index == spr_machroll)
	    {
	        sprite_index = spr_player_backslideland
	        image_index = 0
	    }
	    if (sprite_index == spr_machroll && (!grounded))
	        sprite_index = spr_mach2jump
	    if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_backslideland)
	        sprite_index = spr_player_backslide
	    if (sprite_index == spr_player_Sjumpcancel && grounded)
	        sprite_index = spr_player_Sjumpcancelland
	    if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_Sjumpcancelland)
	        sprite_index = spr_player_Sjumpcancelslide
	    if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_breakdance)
	    {
			with instance_create(x, y, obj_jumpdust)
				image_xscale = other.xscale;
	        movespeed = 12
	        sprite_index = spr_player_breakdancesuper
	    }
	    if (sprite_index == spr_tumblestart && floor(image_index) == (image_number - 1))
	    {
	        sprite_index = spr_tumble
	        movespeed = 14
	    }
		
	    if (((place_meeting(x + xscale, y, obj_solid) or scr_solid_slope(x + xscale, y)) && (!(place_meeting((x + hsp), y, obj_rollblock))) && (!(place_meeting((x + hsp), y, obj_rattumble))) && (!(place_meeting((x + hsp), y, obj_destructibles)))) or place_meeting(x, y, obj_timedgate))
	    {
	        hsp = 0
	        movespeed = 0
	    }
	    if key_jump
	        input_buffer_jump = 0
	    if (!key_jump2 && !jumpstop && vsp < 0.5)
	    {
	        vsp /= 2
	        jumpstop = true
	    }
	    if (grounded && vsp > 0 && (!(place_meeting(x, y, obj_bigcheese))))
	        jumpstop = false
	    if (input_buffer_jump < 8 && grounded && hsp != 0 && sprite_index == spr_tumble)
	    {
	        with (instance_create(x, y, obj_highjumpcloud2))
	            image_xscale = other.xscale
	        vsp = -11
	        image_index = 0
	    }
	    if (crouchslipbuffer > 0)
	        crouchslipbuffer--
	    if (!key_down && key_attack && grounded && sprite_index != spr_tumble && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) && sprite_index != spr_player_breakdance)
	    {
	        if (crouchslipbuffer == 0)
	        {
	            with (instance_create(x, y, obj_jumpdust))
	                image_xscale = other.xscale
	            if (movespeed >= 12)
	                state = states.mach3
	            else
	                state = states.mach2
	            image_index = 0
	            sprite_index = spr_rollgetup
	        }
	    }
	    if ((!key_down) && (!key_attack) && grounded && sprite_index != spr_tumble && (!(scr_solid(x, (y - 16)))) && (!(scr_solid(x, (y - 32)))) && sprite_index != spr_player_breakdance)
	    {
	        if (crouchslipbuffer == 0)
	        {
	            if (movespeed > 6)
	            {
	                state = states.machslide
	                sprite_index = spr_machslidestart
	                image_index = 0
	            }
	            else
	                state = states.normal
	        }
	    }
		
	    if (sprite_index == spr_player_Sjumpcancelslide or sprite_index == spr_player_breakdancesuper or sprite_index == spr_machroll or sprite_index == spr_tumble or sprite_index == spr_tumblestart or sprite_index == spr_machroll or sprite_index == spr_mach2jump)
	        image_speed = (abs(movespeed) / 15)
	    else if (floor(image_index) == (image_number - 1) && sprite_index == spr_mach2jump)
	        image_speed = 0
	    else if (floor(image_index) == (image_number - 1) && sprite_index == spr_player_Sjumpcancel)
	        image_speed = 0
	    else
	        image_speed = 0.35
		
	    if !instance_exists(dashcloudid) && grounded
	    {
	        with instance_create(x, y, obj_dashcloud)
	        {
	            image_xscale = other.xscale
	            other.dashcloudid = id
	        }
	    }
	}
	else
	{
		hsp = xscale * movespeed
		mask_index = spr_crouchmask

		if sprite_index == spr_tumblestart
			movespeed = 6
	
		if !scr_slope() && sprite_index = spr_tumblestart && floor(image_index) < 11
			image_index = 11
	
		if sprite_index == spr_tumblestart && floor(image_index) >= image_number - 1
		{
			sprite_index = spr_tumble
			movespeed = 14
		}
	
		// bump
		if !grounded && !place_meeting(x + hsp, y, obj_car)
			ledge_bump();
	
		if (scr_solidwall(x + xscale, y)
		&& !place_meeting(x + hsp, y, obj_destructibles)
		&& !place_meeting(x + hsp, y, obj_rollblock))
		or place_meeting(x, y, obj_timedgate)
		{
			if sprite_index != spr_tumbleend
			{
				image_index = 0
				scr_soundeffect(sfx_tumble4)
				sprite_index = spr_tumbleend
			}
			state = states.bump;
			hsp = 0
			movespeed = 0
		}

		//Input buffer jumping
		if key_jump
			input_buffer_jump = 0

		//Jump Stop
		if !key_jump2 && !jumpstop && vsp < 0.5
		{
			vsp /= 2
			jumpstop = true
		}

		if grounded && vsp > 0
			jumpstop = false
	
		//Jump
		if input_buffer_jump < 8 && grounded && hsp != 0 && !key_down && !scr_solid(x, y - 32)
		{
			if scr_stylecheck(2)
				scr_soundeffect(sfx_jump)
			input_buffer_jump = 8
		
			vsp = -9
			if global.gameplay != 0
				vsp = -11
		
			with instance_create(x, y, obj_highjumpcloud2)
				image_xscale = other.xscale
		}
		image_speed = 0.35
	
		//Effect
		if !instance_exists(dashcloudid) && grounded
		{
			with instance_create(x, y, obj_dashcloud)
			{
				image_xscale = other.xscale
				other.dashcloudid = id
			}
		}
	}
}