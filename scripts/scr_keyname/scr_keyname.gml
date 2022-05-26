///string_keycheck(key);
function scr_keyname(argument0)
{
	//Checks the given key and returns it as a string. Also detects vk_constants.

	// vk_constants
	//Left
	if argument0 = (vk_left)
	{
		return "LEFT";
	}

	//Right
	if argument0 = (vk_right)
	{
		return "RIGHT";
	}

	//Up
	if argument0 = (vk_up)
	{
		return "UP";
	}

	//Down
	if argument0 = (vk_down)
	{
		return "DOWN";
	}

	//Enter
	if argument0 = (vk_enter)
	{
		return "ENTER";
	}

	//Escape
	if argument0 = (vk_escape)
	{
		return "ESCAPE";
	}

	//Space
	if argument0 = (vk_space)
	{
		return "SPACE";
	}

	//Shift
	if argument0 = (vk_shift)
	{
		return "SHIFT";
	}

	//Control
	if argument0 = (vk_control)
	{
		return "CONTROL";
	}

	//Alt
	if argument0 = (vk_alt)
	{
		return "ALT";
	}

	//Backspace
	if argument0 = (vk_backspace)
	{
		return "BACKSPACE";
	}

	//Tab
	if argument0 = (vk_tab)
	{
		return "TAB";
	}

	//Home
	if argument0 = (vk_home)
	{
		return "HOME";
	}

	//End
	if argument0 = (vk_end)
	{
		return "END";
	}

	//Delete
	if argument0 = (vk_delete)
	{
		return "DELETE";
	}

	//Insert
	if argument0 = (vk_insert)
	{
		return "INSERT";
	}

	//Page Up
	if argument0 = (vk_pageup)
	{
		return "PAGE UP";
	}

	//Page Down
	if argument0 = (vk_pagedown)
	{
		return "PAGE DOWN";
	}

	//Pause
	if argument0 = (vk_pause)
	{
		return "PAUSE";
	}

	//Printscreen
	if argument0 = (vk_printscreen)
	{
		return "PRINT SCREEN";
	}

	//F1
	if argument0 = (vk_f1)
	{
		return "F1";
	}

	//F2
	if argument0 = (vk_f2)
	{
		return "F2";
	}

	//F3
	if argument0 = (vk_f3)
	{
		return "F3";
	}

	//F4
	if argument0 = (vk_f4)
	{
		return "F4";
	}

	//F5
	if argument0 = (vk_f5)
	{
		return "F5";
	}

	//F6
	if argument0 = (vk_f6)
	{
		return "F6";
	}

	//F7
	if argument0 = (vk_f7)
	{
		return "F7";
	}

	//F8
	if argument0 = (vk_f8)
	{
		return "F8";
	}

	//F9
	if argument0 = (vk_f9)
	{
		return "F9";
	}

	//F10
	if argument0 = (vk_f10)
	{
		return "F10";
	}

	//F11
	if argument0 = (vk_f11)
	{
		return "F11";
	}

	//F12
	if argument0 = (vk_f12)
	{
		return "F12";
	}

	//Numpad 0
	if argument0 = (vk_numpad0)
	{
		return "NUMPAD 0";
	}

	//Numpad 1
	if argument0 = (vk_numpad1)
	{
		return "NUMPAD 1";
	}

	//Numpad 2
	if argument0 = (vk_numpad2)
	{
		return "NUMPAD 2";
	}

	//Numpad 3
	if argument0 = (vk_numpad3)
	{
		return "NUMPAD 3";
	}

	//Numpad 4
	if argument0 = (vk_numpad4)
	{
		return "NUMPAD 4";
	}

	//Numpad 5
	if argument0 = (vk_numpad5)
	{
		return "NUMPAD 5";
	}

	//Numpad 6
	if argument0 = (vk_numpad6)
	{
		return "NUMPAD 6";
	}

	//Numpad 7
	if argument0 = (vk_numpad7)
	{
		return "NUMPAD 7";
	}

	//Numpad 8
	if argument0 = (vk_numpad8)
	{
		return "NUMPAD 8";
	}

	//Numpad 9
	if argument0 = (vk_numpad9)
	{
		return "NUMPAD 9";
	}

	//Multiply
	if argument0 = (vk_multiply)
	{
		return "MULTIPLY";
	}

	//Divide
	if argument0 = (vk_divide)
	{
		return "DIVIDE";
	}

	//Add
	if argument0 = (vk_add)
	{
		return "ADD";
	}

	//Subtract
	if argument0 = (vk_subtract)
	{
		return "SUBTRACT";
	}

	//Decimal
	if argument0 = (vk_decimal)
	{
		return "DECIMAL";
	}

	if argument0 = (-1)
	{
		return "PRESS KEY";
	}

	// Printable characters.
	return chr(argument0);


}
function scr_keyfromname(str)
{
	str = string_replace_all(str, " ", "");
	str = string_upper(str);
	
	switch str
	{
		default: return ord(str);
		
		case "SPACE": return vk_space;
		case "UP": return vk_up;
		case "DOWN": return vk_down;
		case "LEFT": return vk_left;
		case "RIGHT": return vk_right;
		case "TAB": return vk_tab;
		case "ENTER": case "RETURN": return vk_enter;
		case "ADD": return vk_add;
		case "ALT": return vk_alt;
		case "ANY": return vk_anykey;
		case "BACKSPACE": return vk_backspace;
		case "CONTROL": case "CTRL": return vk_control;
		case "DECIMAL": return vk_decimal;
		case "ESCAPE": return vk_escape;
		case "SHIFT": return vk_shift;
		case "HOME": return vk_home;
		case "END": return vk_end;
		case "DELETE": case "DEL": return vk_delete;
		case "INSERT": case "INS": return vk_insert;
		case "PAGEUP": return vk_pageup;
		case "PAGEDOWN": return vk_pagedown;
		case "PAUSE": return vk_pause;
		case "PRINTSCREEN": case "IMPPNT": case "PRTSC": case "PRTSCR": case "PRINT": return vk_printscreen;
		case "F1": return vk_f1;
		case "F2": return vk_f2;
		case "F3": return vk_f3;
		case "F4": return vk_f4;
		case "F5": return vk_f5;
		case "F6": return vk_f6;
		case "F7": return vk_f7;
		case "F8": return vk_f8;
		case "F9": return vk_f9;
		case "F10": return vk_f10;
		case "F11": return vk_f11;
		case "F12": return vk_f12;
		case "NUMPAD0": return vk_numpad0;
		case "NUMPAD1": return vk_numpad1;
		case "NUMPAD2": return vk_numpad2;
		case "NUMPAD3": return vk_numpad3;
		case "NUMPAD4": return vk_numpad4;
		case "NUMPAD5": return vk_numpad5;
		case "NUMPAD6": return vk_numpad6;
		case "NUMPAD7": return vk_numpad7;
		case "NUMPAD8": return vk_numpad8;
		case "NUMPAD9": return vk_numpad9;
		case "MULTIPLY": return vk_multiply;
		case "DIVIDE": return vk_divide;
		case "SUBTRACT": case "SUBSTRACT": return vk_subtract;
		
		// these don't work unless using keyboard_check_direct.
		case "LEFTSHIFT": case "LSHIFT": return vk_lshift;
		case "LEFTCONTROL": case "LCONTROL": case "LEFTCTRL": case "LCTRL": return vk_lcontrol;
		case "LEFTALT": case "LALT": return vk_lalt;
		case "RIGHTSHIFT": case "RSHIFT": return vk_rshift;
		case "RIGHTCONTROL": case "RCONTROL": case "RIGHTCTRL": case "RCTRL": return vk_rcontrol;
		case "RIGHTALT": case "RALT": return vk_ralt;
	}
}

