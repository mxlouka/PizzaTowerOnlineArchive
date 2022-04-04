// spawn random debris
if global.panic
{
	repeat min(round((room_width * room_height) / (960 * 540)) * 8, 64)
	{
		with instance_create(irandom(room_width), irandom(room_height), obj_debris)
			vsp = 12;
	}
}
event_user(0);

