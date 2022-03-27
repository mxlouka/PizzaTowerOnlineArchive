if room == rm_editor exit;

sprite_index = scr_collectsprite();
image_speed = 0.35;

depth = 1;
if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	depth += 100;
ID = -1;
