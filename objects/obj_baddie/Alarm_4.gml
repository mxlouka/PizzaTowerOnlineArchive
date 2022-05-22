with instance_create(x, y, obj_enemyafterimage)
{
	parent = other.id;
	sprite_index = sprite_index;
	image_index = image_index;
	image_xscale = image_xscale;
}
if grounded
{
    with instance_create(x, y, obj_dashcloud2)
        image_xscale = other.image_xscale
}
if state == states.rage
	alarm[4] = 5;

