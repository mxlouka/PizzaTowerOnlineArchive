draw_self()
if grounded && !scr_solid(x,y)
{
	pickupimg += 0.35;
	
	var yy = y;
	if sprite_index == spr_canecollect
		yy -= 12;
	draw_sprite(spr_grabicon, pickupimg, x - 12, yy)
}

