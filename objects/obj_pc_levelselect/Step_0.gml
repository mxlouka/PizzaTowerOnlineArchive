scr_getinput();
obj_pc_player.canmove = false;

// start level
if keyboard_check_pressed(ord("Z"))
{
	// apply player
	with obj_pc_player
	{
		paletteselect = 0;
		targetDoor = "A";
		switch other.char
		{
			case 0:
				character = "P";
				paletteselect = 1;
				break;
			case 1:
				character = "N";
				break;
			case 2:
				character = "V";
				break;
			case 3:
				character = "S";
				break;
			case 4:
				character = "SP";
				paletteselect = 1;
				break;
			case 5:
				character = "PP";
				break;
		}
		scr_characterspr();
	}
	
	// according to selection
	switch sel
	{
		case 0: // scape
			audio_stop_all();
			global.panic = true;
			global.minutes = 2;
			global.seconds = 59;
			obj_pc_player.alarm[0] = room_speed;
			room_goto(pc_escape_1);
			break;
	}
}

// control
if keyboard_check_pressed(vk_down)
	sel += 1;
if keyboard_check_pressed(vk_up)
	sel -= 1;

// loop control
if sel > array_length(levels) - 1
	sel = 0;
if sel < 0
	sel = array_length(levels) - 1;

// switch character
if keyboard_check_pressed(vk_right)
	char += 1;
if keyboard_check_pressed(vk_left)
	char -= 1;
char = clamp(char, 0, 5);

