if global.panic or global.snickchallenge
{
	if !(global.minutes <= 0 && global.seconds <= 0)
	{
		global.seconds -= 1;
		global.collect -= 5;
		if global.collect < 0
			global.collect = 0;
		if global.seconds < 0
		{
			global.seconds += 60;
			global.minutes -= 1;
		}
	}
	
	if global.minutes <= 0
	&& global.seconds <= 0
	&& !global.snickchallenge
	{
		/*
		if global.gustavocon > 0
		{
			global.gustavocon = 666;
			global.panic = false;
			burger = false;
			room_goto(sewer_gustavo);
			exit;
		}
		else
		*/
		{
			audio_stop_all();
			room_goto(pc_titlescreen);
		}
	}
}

alarm[0] = room_speed;

