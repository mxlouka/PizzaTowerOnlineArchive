if instance_exists(obj_onlinemenu)
{
	global.pizzacoin = global.pizzacoinstart;
	
	scr_playerreset();
	with obj_player
	{
		targetDoor = "B";
		state = states.titlescreen;
	}
	
	with obj_onlinemenu
	{
		gmsroom = -1;
		if userid == level_userid
			menu = menutypes.leveldetails;
		else
			menu = menutypes.vote;
	}
	room_goto(editor_entrance);
}
else
{
	global.pizzacoinstart = global.pizzacoin;
	if global.timeattack
	{
		ini_open("saveData" + string(global.saveslot) + ".ini");
		scr_savetatime(scr_levelname());
		ini_close();
	}
	
	scr_playerreset()
	with obj_player
	{
		state = states.normal
		targetDoor = "A"
	}
	room_goto(hub_room1);
}