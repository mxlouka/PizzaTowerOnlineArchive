function scr_characterentrance(argument0)
{
	// shitk golf
	if (audio_is_playing(mu_minigolf) && scr_checkskin(checkskin.s_shit))
	or (audio_is_playing(mu_susgolf) && !scr_checkskin(checkskin.s_shit))
	{
		audio_stop_sound(mu_minigolf);
		audio_stop_sound(mu_susgolf);
		with obj_music
			event_perform(ev_other, ev_room_start);
	}
	
	// entrance
	var roomname = room_get_name(room)
	if string_letters(roomname) == "entrance"
	or (string_letters(roomname) == "waffle" && sugaryspire)
	{
		with obj_music
			alarm[1] = 1;
	}
}

