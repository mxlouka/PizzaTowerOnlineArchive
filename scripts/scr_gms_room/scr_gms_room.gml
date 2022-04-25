function scr_gms_room()
{
	if room != custom_lvl_room
	{
		// merge old with new rooms (may show players inside walls with gameplay difference, but...)
		var r = room;
		var rname = room_get_name(r);
		
		if string_endswith(rname, "_NEW")
			r = asset_get_index(string_replace(rname, "_NEW", ""));
		if r == -1
			r = room;
		
		return r;
	}
	else
	{
		// in the level editor.
		if obj_onlinemenu.gmsroom > -1
			return obj_onlinemenu.gmsroom;
		else
			return -obj_onlinemenu.level_id;
	}
}

