function scr_player_rocket()
{
	hsp = xscale * movespeed
    move = key_right + key_left
    vsp = 0
    alarm[5] = -1
    alarm[8] = 60
    alarm[7] = 120
    hurted = true
	
    if sprite_index != spr_rocketstart
    {
        if key_up && !fightball
            vsp = -3
        if key_down && !fightball
            vsp = 3
        if movespeed < 14
            movespeed = 14
    }
    else
    {
        hsp = 0
        movespeed = 0
        vsp = 0
        if floor(image_index) == image_number - 1
        {
            sprite_index = spr_rocket
            image_index = 0
            movespeed = 14
        }
    }
    if movespeed < 24 && move == xscale
    {
        movespeed += 0.1
        if !instance_exists(crazyruneffectid) && grounded
        {
            with instance_create(x, y, obj_crazyruneffect)
            {
                playerid = other.object_index
                other.crazyruneffectid = id
            }
            if sprite_index == spr_crazyrun
            {
                with instance_create(x, y, obj_dashcloud)
                {
                    image_xscale = other.xscale
                    sprite_index = spr_flamecloud
                }
            }
        }
    }
    else if movespeed > 12 && move != xscale && !pizzapepper
        movespeed -= 0.1
	
    if !fightball
    {
        if sprite_index != spr_rocketstart
            sprite_index = spr_rocket
    }
    if !key_jump2 && !jumpstop && vsp < 0.5 && fightball
    {
        vsp /= 10
        jumpstop = true
    }
    if grounded && vsp > 0 && fightball
        jumpstop = false
	
    if scr_solid(x + sign(hsp), y)
	&& (!place_meeting(x + sign(hsp), y, obj_slope) or place_meeting(x + sign(hsp), y, obj_solid))
	&& !place_meeting((x + sign(hsp)), y, obj_metalblock)
	&& character != "V" && !place_meeting(x + sign(hsp), y, obj_destructibles)
	&& character != "V" && !place_meeting(x + sign(hsp), y, obj_hungrypillar)
    {
        pizzapepper = false
        sprite_index = spr_rockethitwall
        scr_soundeffect(sfx_groundpound)
        scr_soundeffect(sfx_bumpwall)
		
        with obj_camera
        {
            shake_mag = 20
            shake_mag_acc = 40 / room_speed
        }
        hsp = 0
        image_speed = 0.35
		
        with obj_baddie
        {
            if point_in_camera(x, y, view_camera[0])
            {
                stun = true
                alarm[0] = 200
                ministun = false
                vsp = -5
                hsp = 0
            }
        }
		
        flash = false
        state = states.bump
        hsp = -3.5 * xscale
        vsp = -6
        mach2 = 0
        image_index = 0
        instance_create(x - 10, y + 10, obj_bumpeffect)
        instance_create(x, y, obj_playerexplosion)
    }
    if !instance_exists(dashcloudid) && grounded && !place_meeting(x, y + 1, obj_water)
    {
        with instance_create(x, y, obj_superdashcloud)
        {
            if other.fightball
                instance_create(obj_player.x, obj_player.y, obj_slapstar)
            image_xscale = other.xscale
            other.dashcloudid = id
        }
    }
    if sprite_index != spr_rocketstart && !instance_exists(chargeeffectid)
    {
        with instance_create(x, y, obj_chargeeffect)
        {
            playerid = other.object_index
            other.chargeeffectid = id
        }
    }
	
    if sprite_index == spr_mach4 or sprite_index == spr_fightball
        image_speed = 0.4
    if sprite_index == spr_crazyrun
        image_speed = 0.75
    if sprite_index == spr_rollgetup or sprite_index == spr_mach3hit
        image_speed = 0.4
    else
        image_speed = 0.4
}