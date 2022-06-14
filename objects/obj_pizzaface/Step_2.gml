var playerid = obj_player;
if !instance_exists(playerid)
	exit;

if sugary
{
	alarm[1] = -1
	siner--
	
	if sprite_index == spr_coneball or sprite_index == spr_coneballturn or sprite_index == spr_coneballspike
	{
		if x != playerid.x && sprite_index == spr_coneball
		{
			var xscale = sign(x - playerid.x);
			if image_xscale != xscale
			{
				image_xscale = xscale;
				sprite_index = spr_coneballturn;
				image_index = 0;
			}
		}
		if image_index >= image_number - 1 && (sprite_index == spr_coneballturn or sprite_index == spr_coneballspike)
		{
			image_index = 0;
			sprite_index = spr_coneball;
		}
		xx = lerp(xx, (playerid.x + cos(current_time / 1000) * -150) - _camx, 0.05);
		yy = lerp(yy, (playerid.y + sin(current_time / 1000) * -150) - _camy, 0.05);
		
		if siner <= 0
		{
			if attack % 2 == 0
			{
				siner = room_speed * 8;
				image_index = 0;
				sprite_index = spr_coneballraintrans;
				attack++;
			}
			else
			{
				siner = room_speed * random_range(4, 8);
				attack++;
				sprite_index = spr_coneballspike;
				image_index = 0;
			}
		}
		
		if sprite_index == spr_coneballspike
		{
			if floor(image_index) == 10
				mask_index = sprite_index;
			
			if place_meeting(x, y, playerid) && !instance_exists(obj_fadeout) && !instance_exists(obj_endlevelfade) && playerid.state != states.portal && playerid.state != states.door
			{
				if !place_meeting(x, y, obj_parryhitbox) && playerid.state != states.parry && image_index >= 14
				{
					with playerid
					{
						image_blend = c_white;
						grav = 0.5;
						a = 0;
						targetDoor = "A"
						room = timesuproom
						state = states.timesup
						sprite_index = spr_Timesup
						image_index = 0
						image_speed = 0.35
				
						if !audio_is_playing(global.jukebox)
						{
							audio_stop_all()
							scr_soundeffect(mu_timesup)
						}
						instance_destroy(obj_fadeout)
						instance_destroy(other)
					}
					scr_soundeffect(sfx_coneball);
				}
			}
		}
		else
			mask_index = spr_player_mask;
	}
	if sprite_index == spr_coneballraintrans or sprite_index == spr_coneballrain or sprite_index == spr_coneballrainturn
	{
		xx = lerp(xx, (playerid.x + playerid.xscale * -150) - _camx, 0.05);
		yy = lerp(yy, (playerid.y - 150) - _camy, 0.05);
		
		if x != playerid.x && sprite_index == spr_coneballrain
		{
			var xscale = sign(x - playerid.x);
			if image_xscale != xscale
			{
				image_xscale = xscale;
				sprite_index = spr_coneballrainturn;
				image_index = 0;
			}
		}
		if image_index >= image_number - 1 && (sprite_index == spr_coneballraintrans or sprite_index == spr_coneballrainturn)
		{
			sprite_index = spr_coneballrain;
			image_index = 0;
		}
		
		if siner % 18 == 0
			instance_create(random_range(_camx, _camx + _camw), _camy - 64, obj_coneprojectile)
		
		if siner <= 0
		{
			image_alpha -= 0.1;
			if image_alpha <= 0
			{
				image_alpha = 1;
				siner = room_speed * random_range(4, 8);
				sprite_index = spr_coneball;
				reset_pos();
			}
		}
	}
	x = xx + _camx;
	y = yy + _camy;
}
else
{
	if image_alpha >= 1	
	{
		if global.gameplay == 0
		{
			x = Approach(x, playerid.x, maxspeed);
			y = Approach(y, playerid.y, maxspeed);
		}
		else
		{
			var dir = point_direction(x, y, playerid.x, playerid.y)
		    x += lengthdir_x(maxspeed, dir)
		    y += lengthdir_y(maxspeed, dir)
		}
	}
	else
		image_alpha += 0.01	
	
	if place_meeting(x, y, playerid) && !instance_exists(obj_fadeout) && !instance_exists(obj_endlevelfade) && playerid.state != states.portal && playerid.state != states.door && image_alpha == 1
	{
		if instance_exists(obj_toppinwarrior)
		{
			if variable_global_exists("toppinwarriorid1") && instance_exists(global.toppinwarriorid1)	
				instance_destroy(global.toppinwarriorid1)	
			else if variable_global_exists("toppinwarriorid2") && instance_exists(global.toppinwarriorid2)	
				instance_destroy(global.toppinwarriorid2)	
			else if variable_global_exists("toppinwarriorid3") && instance_exists(global.toppinwarriorid3)	
				instance_destroy(global.toppinwarriorid3)	
			else if variable_global_exists("toppinwarriorid4") && instance_exists(global.toppinwarriorid4)	
				instance_destroy(global.toppinwarriorid4)
			else if variable_global_exists("toppinwarriorid5") && instance_exists(global.toppinwarriorid5)	
				instance_destroy(global.toppinwarriorid5)	
		
			instance_create(x, y, obj_flash)
			global.seconds = 59
			obj_camera.alarm[1] = 60
			obj_camera.ded = false
			instance_destroy()
		}
		else
		{
			/*
			if sugary && (global.collect > 0 or place_meeting(x, y, obj_parryhitbox) or playerid.state == states.parry)
			{
				if !place_meeting(x, y, obj_parryhitbox)
					scr_hurtplayer(playerid, 100);
			}
			else if !playerid.hurted or !sugary*/
			{
				with playerid
				{
					image_blend = c_white;
					grav = 0.5;
					a = 0;
					targetDoor = "A"
					room = timesuproom
					state = states.timesup
					sprite_index = spr_Timesup
					image_index = 0
					image_speed = 0.35
				
					if !audio_is_playing(global.jukebox)
					{
						audio_stop_all()
						scr_soundeffect(mu_timesup)
					}
					instance_destroy(obj_fadeout)
					instance_destroy(other)
				}
			}
		}
	}
	
	if maxspeed < global.gameplay == 0 ? 5 : 3 && image_alpha == 1
	{
		maxspeed += 0.01
		if maxspeed < 1
			maxspeed += 0.1;
	}
}
