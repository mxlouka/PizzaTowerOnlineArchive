if string_startswith(room_get_name(room), "floor2")
{
	with other
	{
		if scr_transfobump()
			exit;
	}
}
scr_hurtplayer(other);

