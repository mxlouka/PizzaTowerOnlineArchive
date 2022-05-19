if room == rm_editor exit;

sprite_index = scr_collectsprite();
image_speed = 0.35;

depth = 1;
if scr_depthcheck()
	depth += 100;
ID = -1;
