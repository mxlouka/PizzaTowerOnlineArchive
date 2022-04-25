if global.jukebox != -1
	audio_resume_sound(global.jukebox);

if instance_exists(obj_onlinemenu)
{
	global.pizzacoin = global.pizzacoinstart;
	
	scr_playerreset();
	with obj_player
	{
		targetDoor = "B";
		state = states.titlescreen;
	}
	
	obj_onlinemenu.gmsroom = -1;
	obj_onlinemenu.menu = menutypes.leveldetails;
	room_goto(editor_entrance);
}
else
{
	global.pizzacoinstart = global.pizzacoin;
	
	scr_playerreset();
	if scr_stylecheck(2)
	{
		with obj_player
		{
			targetDoor = "NONE";
			if backtohubstartx == 0 && backtohubstarty == 0
				targetDoor = "A";
			else
			{
				x = backtohubstartx;
				y = backtohubstarty;
			}
			room_goto(backtohubroom);
			
			backtohubstartx = 0;
			backtohubstarty = 0;
			backtohubroom = hub_room1;
		}
	}
	else
	{
		with obj_player
			targetDoor = "A";
		room_goto(hub_room1);
	}
}

