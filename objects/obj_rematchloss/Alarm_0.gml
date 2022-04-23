instance_activate_all();
room_goto(hub_room1);
if !audio_is_playing(global.jukebox)
	audio_stop_all();
alarm[1] = 2;