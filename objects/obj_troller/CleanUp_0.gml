/// @description basically the destroy event
if global.snickchallenge && global.snickrematch
{
	audio_stop_sound(vinefunny);

	if object_exists(snick)
	{
		var dir = irandom_range(0, 360);
		instance_create(x + lengthdir_x(75, dir), y + lengthdir_x(75, dir), snick);
		instance_create(x - lengthdir_x(75, dir), y - lengthdir_x(75, dir), snick);
	}
}

