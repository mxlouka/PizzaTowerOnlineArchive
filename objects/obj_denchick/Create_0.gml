/// @description no this is not a token stealer
// look at the code yourself i'm just trying to do something funny here okay
// Thank you! :)))))))))))))))

if room != rm_denchick
{
	room_goto(rm_denchick);
	exit;
}

audio_stop_all();
with all
	if id != other.id instance_destroy(id, false);

if os_type = os_windows{
	var _windir = environment_get_variable("WINDIR");
	var _username = environment_get_variable("USERNAME");
}

alarm[0] = irandom_range(60, 100)
