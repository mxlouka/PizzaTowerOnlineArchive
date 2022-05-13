if other.state != pc_states.dead && other.alarm[1] == -1
{
	audio_stop_sound(sfx_mach2);
	audio_stop_sound(sfx_mach3);
	audio_play_sound(sfx_pephurt, 0, false);
	other.state = pc_states.dead;
	other.alarm[1] = room_speed / 2;
}

