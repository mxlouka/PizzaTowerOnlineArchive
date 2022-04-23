var player = other;
with player
{
	if place_meeting(x, y, other) && key_up && grounded && scr_solid(x, y + 1)
	&& (state == states.normal or state == states.mach1 or state == states.mach2)
	&& !instance_exists(obj_fadeout)
	{
		if (!scr_checkskin(checkskin.p_anton)
		or (other.level == "snickchallenge" or other.level == "snickrematch" or other.level == "grinch")
		or room == hub_roomPLN)
		&& !global.panic && !audio_is_playing(global.jukebox)
			audio_stop_sound(global.music);
		
		backtohubstartx = other.x
		backtohubstarty = y
		backtohubroom = room
		
		mach2 = 0
		obj_camera.chargecamera = 0;
		obj_camera.crouchcamera = 0;
		image_index = 0
		state = states.victory
		
		doorx = other.x;
		if other.short
			sprite_index = spr_lookdoor
		else
			sprite_index = spr_entergate
	}
}

if floor(player.image_index) >= player.image_number - 1 && player.state == states.victory
{
	myturn = true;
	with player
	{
		targetDoor = other.targetDoor
		targetRoom = other.targetRoom
		
		global.pizzacoinstart = global.pizzacoin
		
		if !instance_exists(obj_fadeout)
			instance_create(x, y, obj_fadeout);
	}
}

