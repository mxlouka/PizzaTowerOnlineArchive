if !audio_is_playing(selarray[sel[1]][0])
{
	audio_stop_all();
	
	global.music = audio_play_sound(selarray[sel[1]][0], 1, true);
	audio_sound_gain(global.music, global.musicvolume, 0);
	global.jukebox = global.music;
}
else
{
	audio_stop_all();
	global.jukebox = -1;
}

