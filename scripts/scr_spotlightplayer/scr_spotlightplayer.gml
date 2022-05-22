function scr_spotlightplayer()
{
	if !global.coop
		return obj_player1;
	else
	{
		if !instance_exists(obj_player) or obj_player1.spotlight
			return obj_player1;
		else
			return obj_player2;
	}
}

