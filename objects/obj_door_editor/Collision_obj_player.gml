/// @description 
if index == -1 exit;
var door_id = id;

if !place_meeting(x, y, obj_doorblocked)
with other
{
	if key_up && grounded && (state == states.normal or state == states.mach1 or state == states.mach2 or state == states.pogo or state == states.mach3 or state == states.Sjumpprep) 
	&& y == door_id.y + 50 && !instance_exists(obj_noisesatellite) && !instance_exists(obj_fadeout) && state != states.door && state != states.comingoutdoor
	{
		index = door_id.index;
		scr_soundeffect(sfx_door)
		
		with obj_camera
			chargecamera = 0
	
		sprite_index = spr_lookdoor
		
		image_index = 0
		state = states.door
		mach2 = 0
		doorx = door_id.x + 50;
		
		door_id.visited = true
		with instance_create(x, y, obj_fadeout)
		{
			_id = door_id;
			index = door_id.index;
			custom_level = true;
		}
	}
}
