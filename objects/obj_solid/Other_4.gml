if object_index == obj_solid
{
	if irandom_range(1, 100) == 5 or global.facesolids
	{
		sprite_index = spr_facesolid;
		image_speed = 0;
		image_index = irandom(image_number);
	}
}

