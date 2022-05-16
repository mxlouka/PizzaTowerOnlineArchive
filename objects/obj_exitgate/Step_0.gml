if sprite_index != spr_exitgateclosing_ss
{
	if global.failedmod
	{
		if image_index == 1 && instance_in_camera()
		{
			gp_vibration(1, 1, 0.9);
			scr_soundeffect(sfx_groundpound);
			
			with obj_camera
			{
				shake_mag = 5;
				shake_mag_acc = 15 / room_speed;
			}
		}
		image_index = 0;
	}
	else if global.panic
		image_index = 1;
}
else if floor(image_index) >= image_number - 1
{
	sprite_index = spr_exitgate_ss;
	image_index = 0;
	image_speed = 0;
}

// disable if youre snick
var snick = false;
with obj_player1
	if character == "S" snick = true;

visible = !snick;
if snick
	exit;

// snick rematch end slowdown
if room == snick_challengeend && global.snickrematch
    audio_sound_pitch(global.music, min(distance_to_object(obj_player1) / (room_width - 480), 1));

