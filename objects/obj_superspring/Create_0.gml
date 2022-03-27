image_speed = 0.5
image_index = 5

depth = 1;
if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	depth += 100;

if check_sugary()
	sprite_index = spr_springup_ss;
