// fade out music if mach4 pissino is playing
faded = false;
trigger = true; // run every frame

func = function()
{
	if audio_is_playing(sfx_mach4_PP)
	{
		audio_sound_gain(global.music, 0, 2000);
		faded = true;
	}
	else if faded
	{
		audio_sound_gain(global.music, global.musicvolume, 500);
		faded = false;
	}
}
cleanup = function() {
	audio_sound_gain(global.music, global.musicvolume, 0);
}

