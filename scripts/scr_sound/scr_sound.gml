function scr_sound(mus, loop = true)
{
	// repainted
	if instance_exists(obj_player)
	{
		if obj_player.character == "PP"
		{
			if asset_get_type(audio_get_name(mus) + "_PP") == asset_sound
				mus = asset_get_index(audio_get_name(mus) + "_PP");
		}
	}
	
	global.music = audio_play_sound(mus, 1, loop);
	if room != rm_disclaimer
		audio_sound_gain(global.music, global.musicvolume, 0);
	return global.music;
}

