if live_call() return live_result;

if !audio_is_playing(selarray[sel[1]][0])
{
	audio_stop_all();
	global.jukebox = scr_sound(selarray[sel[1]][0]);
}
else
{
	audio_stop_all();
	global.jukebox = -1;
}

