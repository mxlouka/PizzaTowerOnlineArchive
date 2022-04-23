/// @description 
if scr_checkskin(checkskin.p_anton)
{
	alarm[0] = 1;
	exit;
}
if audio_is_playing(global.jukebox)
	exit;

if (lemusic != obj_music_set.music_editor && audio_is_playing(pausedmusic))
or lemusic == -1
{
	var mus = obj_music_set.music_editor;
	if mus == mu_entrance
	{
		switch obj_player1.character
		{
			case "P":
				mus = mu_entrance
				break
			case "N":
				mus = mu_noiseentrance
				break
			case "SP":
				mus = mu_waffle
				break
			case "S":
				mus = mu_snickentrance
				break
		}
	}
	var musfinal = mus;
	
	// pizza castle
	if global.musicgame == 1
		musfinal = scr_getmidi(musfinal);
	
	audio_stop_all()
	scr_sound(musfinal)
	if continuous
    {
        audio_sound_set_track_position(global.music, fadeoff)
        continuous = false
    }
	pausedmusic = musfinal
	lemusic = mus
}