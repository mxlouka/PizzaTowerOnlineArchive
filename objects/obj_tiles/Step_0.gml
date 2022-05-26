/// @description 
if destroy
{
	if !oneway
	{
		if !instance_exists(inst)
			instance_destroy()
	}
	else
	{
		// detect onways
		if place_meeting(x, y, obj_solid) && place_meeting(x + 32, y, obj_onewaybigblock)
			inst = instance_place(x + 32, y, obj_onewaybigblock);
		if place_meeting(x, y, obj_solid) && place_meeting(x - 32, y, obj_onewaybigblock)
			inst = instance_place(x - 32, y, obj_onewaybigblock);
		
		if place_meeting(x, y, obj_onewaybigblock)
			inst = instance_place(x, y, obj_onewaybigblock);
		
		if inst != noone
		{
			if !instance_exists(inst)
				instance_destroy();
		}
	}
}

