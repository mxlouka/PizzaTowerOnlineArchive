with obj_player1
{
	instance_destroy(other)
	global.key_inv += 1
	key_particles = true
	alarm[7] = 30
	audio_stop_sound(sfx_collecttoppin)
	scr_soundeffect(sfx_collecttoppin)
}

