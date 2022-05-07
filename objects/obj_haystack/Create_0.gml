image_speed = 0.35
mask_index = spr_haystack
depth = 1

gameplay = global.gameplay;
if string_startswith(room_get_name(room), "floor2")
	gameplay = 0;

