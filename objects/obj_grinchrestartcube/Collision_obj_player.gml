if !instance_exists(obj_fadeout) && other.state != states.gameover && !other.cutscene && !other.godmode
{
	if !audio_is_playing(global.jukebox)
		audio_stop_all();
	
	scr_playerreset();
	with obj_player1
	{
		c = 0;
		state = states.comingoutdoor;
		targetDoor = "A";
	}
	room_goto(grinch_1);
}

