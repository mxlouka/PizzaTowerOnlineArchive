if live_call() return live_result;

scr_getinput(true);
function draw_inputdisplay_key(xx, yy, keycode, width, height = width)
{
	var drawer = "A";
	var pressed = false;
	switch keycode
	{
		case "SHIFT": drawer = "SHIFT"; pressed = key_attack; break;
		case "Z": drawer = "Z"; pressed = key_jump2; break;
		case "X": drawer = "X"; pressed = key_slap; break;
		case "C": drawer = "C"; pressed = key_taunt; break;
		case "UP": drawer = spr_uparrow; pressed = key_up; break;
		case "DOWN": drawer = spr_uparrow; pressed = key_down; break;
		case "LEFT": drawer = spr_uparrow; pressed = -key_left; break;
		case "RIGHT": drawer = spr_uparrow; pressed = key_right; break;
	}
	
	// square
	draw_set_alpha(image_alpha);
	draw_set_colour(pressed ? pressedcol : c_ltgray);
	draw_roundrect(xx, yy, xx + width - 1, yy + height - 1, false);
	
	draw_set_colour(c_black);
	draw_roundrect(xx, yy, xx + width - 1, yy + height - 1, true);
	
	// text
	if !is_string(drawer) && sprite_exists(drawer)
	{
		
	}
	else
	{
		draw_set_colour(c_white);
		draw_set_font(global.bigfont);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
	
		var siz = 1;
		var _stringwidth = string_width(drawer);
	    if _stringwidth >= width - 8
	        siz = (width - 8) / _stringwidth;
	
		if siz < 1
			draw_text_transformed(floor(xx + width / 2), floor(yy + height / 2), drawer, siz, siz, 0);
		else
			draw_text(floor(xx + width / 2), floor(yy + height / 2), drawer);
	
		draw_set_valign(fa_top);
	}
	
	draw_set_alpha(1);
}

if global.inputdisplay
{
	var keysep = 4;
	var keysize = 48;
	var add = keysep + keysize;
	
	// dont block the view
	if instance_exists(obj_player) && obj_player.x >= _camx + x && obj_player.x <= _camx + x + add * 3.5
	&& obj_player.y >= _camy + _camh + y - add * 4 && obj_player.y <= _camy + _camh + y
		image_alpha = 0.5;
	else
		image_alpha = 1;
	
	draw_inputdisplay_key(x + keysep, y + 540 - add, "SHIFT", keysize + add, keysize);
	draw_inputdisplay_key(x + keysep, y + 540 - add * 2, "LEFT", keysize);
	draw_inputdisplay_key(x + keysep + add, y + 540 - add * 2, "DOWN", keysize);
	draw_inputdisplay_key(x + keysep + add, y + 540 - add * 3, "UP", keysize);
	draw_inputdisplay_key(x + keysep + add * 2, y + 540 - add * 2, "RIGHT", keysize);
	draw_inputdisplay_key(x + keysep, y + 540 - add * 3, "Z", keysize);
	draw_inputdisplay_key(x + keysep + add * 2, y + 540 - add * 3, "X", keysize);
	draw_inputdisplay_key(x + keysep + add * 2, y + 540 - add, "C", keysize);
	
	// UP
	draw_sprite_ext(spr_uparrow, 0, x + keysep + add + keysize / 2, y + 540 - add * 3 + keysize / 2 + 3, 0.9, 0.9, 0, c_white, image_alpha);
	
	// DOWN
	draw_sprite_ext(spr_uparrow, 0, x + keysep + add + keysize / 2, y + 540 - add * 2 + keysize / 2 - 2, 0.9, -0.9, 0, c_white, image_alpha);
	
	// LEFT
	draw_sprite_ext(spr_uparrow, 0, x + keysep + keysize / 2 + 3, y + 540 - add * 2 + keysize / 2, 0.9, 0.9, 90, c_white, image_alpha);
	
	// RIGHT
	draw_sprite_ext(spr_uparrow, 0, x + keysep + add * 2 + keysize / 2 - 2, y + 540 - add * 2 + keysize / 2, 0.9, -0.9, 90, c_white, image_alpha);
}
