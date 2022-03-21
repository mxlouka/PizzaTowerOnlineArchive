with other
{
	if place_meeting(x, y, other) && key_up && grounded && state == states.normal
	{
		audio_sound_gain(global.music, 0, 100);
		
		obj_camera.chargecamera = 0;
		image_index = 0;
		state = states.victory;
		
		doorx = x;
		sprite_index = spr_lookdoor;
		other.alarm[0] = room_speed * 4;
	}
}
