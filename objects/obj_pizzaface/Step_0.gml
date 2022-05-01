var playerid = obj_player1;

x = Approach(x, playerid.x, maxspeed);
y = Approach(y, playerid.y, maxspeed);

if place_meeting(x, y, playerid) && !instance_exists(obj_fadeout) && !instance_exists(obj_endlevelfade) && playerid.state != states.portal && playerid.state != states.door
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
	
		instance_create(x,y,obj_flash)
		global.seconds = 59
		obj_camera.alarm[1] = 60
		obj_camera.ded = false
		instance_destroy()
	}
	else
	{
		if sugary && global.collect > 0
			scr_hurtplayer(playerid, 100);
		else with playerid
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
			
			instance_destroy(obj_hallway);
		}
	}
	instance_destroy()
}

if maxspeed < 5 or !sugary
	maxspeed += 0.01

if sugary && x != playerid.x
	image_xscale = -sign(x - playerid.x);

