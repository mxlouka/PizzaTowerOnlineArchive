/// @description create solid
mysolid = instance_create(x + (sprite_width / 4), y, obj_solid);
mysolid.image_yscale = 3;
mysolid.image_xscale = image_xscale;

if scr_stylecheck(1)
	mysolid.sprite_index = other.sprite_index;

