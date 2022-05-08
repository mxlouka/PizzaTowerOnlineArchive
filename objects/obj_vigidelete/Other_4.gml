var checker = (character == "" && (obj_player.character == "V" or obj_player.character == "S")) or obj_player.character == character;
if (!invert && checker) or (invert && !checker)
{
	with all
	{
		if !persistent && place_meeting(x, y, other)
			instance_destroy(id, false);
	}
}

