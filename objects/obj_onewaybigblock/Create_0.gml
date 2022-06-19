event_inherited()
if room == rm_editor exit;

depth = 1
mysolid = noone

if room == custom_lvl_room
	alarm[0] = 1
else
	event_user(0);

if global.gameplay == 0
	sprite_index = spr_onewaybigblock;
if check_sugary()
	sprite_index = spr_onewayblock_ss;

momentum = [0, 0];
image_speed = 0.35;
