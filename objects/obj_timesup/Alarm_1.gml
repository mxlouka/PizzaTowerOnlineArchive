if instance_exists(obj_onlinemenu)
{
	scr_playerreset()
	global.pizzacoin = global.pizzacoinstart;
	
	with obj_player
	{
		targetDoor = "B";
		state = states.titlescreen;
	}
	
	with obj_onlinemenu
	{
		gmsroom = -1;
		if level_id == 0
			menu = menutypes.listfiles;
		else
			menu = menutypes.leveldetails;
	}
	room_goto(editor_entrance);
}
else with obj_player
{
	state = states.gameover;
	y = room_height * 2;
}

