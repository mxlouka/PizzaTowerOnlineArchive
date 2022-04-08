repeat 6 with instance_create(x + random_range(-100, 100), y + random_range(-100, 100), obj_balloonpop)
	sprite_index = spr_shotgunimpact;

if global.snickchallenge && global.snickrematch && !instance_exists(obj_endlevelfade)
{
	// hydra from greek mythology
	var dir = irandom_range(0, 360);
	if !instance_exists(obj_troller)
	{
		with instance_create(x - sprite_get_width(bg_troller) / 2, y - sprite_get_height(bg_troller) / 2, obj_troller)
			image_xscale = 0.5;
	}
	instance_create(x + lengthdir_x(75, dir), y + lengthdir_x(75, dir), object_index);
	instance_create(x - lengthdir_x(75, dir), y - lengthdir_x(75, dir), object_index);
}
/* 
btw not checking if endlevelfade exists literally freezes the game because
the snicks get deleted but when that happens 2 more get added but those get deleted as well
and it just enters an infinite loop
*/

