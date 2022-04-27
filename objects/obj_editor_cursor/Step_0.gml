x = mouse_x;
y = mouse_y;

if image_index >= image_number - 1
	sprite_index = spr_editor_cursor;
if sprite_index == spr_editor_cursor
	image_index = mouse_check_button(mb_left) or mouse_check_button(mb_right);
window_set_cursor(cr_none);

drawtext = "";

