scr_collide();
if scr_solidwall(x + hsp, y - 1) or place_meeting(x + hsp, y, obj_hallway)
	hsp *= -1;

if place_meeting(x, y, obj_otherplayer)
	image_alpha = 0.5;
else
	image_alpha = 1;
