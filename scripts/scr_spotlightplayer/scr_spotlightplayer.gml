function scr_spotlightplayer()
{
	if !global.coop
		return obj_player1;
	else
	{
		if obj_player1.spotlight
			return obj_player1;
		else
			return obj_player2;
	}
}

