if diag != noone && !instance_exists(diag)
{
	audio_sound_gain(global.music, global.musicvolume, 100);
	
	diag = noone;
	with obj_player
		state = states.normal;
}
