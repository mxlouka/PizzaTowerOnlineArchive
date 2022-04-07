repeat 6 with instance_create(x + random_range(-100, 100), y + random_range(-100, 100), obj_balloonpop)
	sprite_index = spr_shotgunimpact;

if global.snickchallenge && global.snickrematch && !instance_exists(obj_endlevelfade)
{
	// cut off one head, two more shall take its place
	var dir = irandom_range(0, 360);
	instance_create(x + lengthdir_x(75, dir), y + lengthdir_x(75, dir), object_index);
	instance_create(x - lengthdir_x(75, dir), y - lengthdir_x(75, dir), object_index);
}

