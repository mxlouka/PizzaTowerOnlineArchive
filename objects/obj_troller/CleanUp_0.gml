if global.snickchallenge && global.snickrematch
{
	audio_stop_sound(vinefunny);

	if room = !rm_denchick
	{
		var dir = irandom_range(0, 360);
		instance_create(x + lengthdir_x(75, dir), y + lengthdir_x(75, dir), snick);
		instance_create(x - lengthdir_x(75, dir), y - lengthdir_x(75, dir), snick);
	}
}

