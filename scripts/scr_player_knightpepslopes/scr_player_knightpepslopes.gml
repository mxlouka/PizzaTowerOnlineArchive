function scr_player_knightpepslopes()
{
	alarm[5] = 2
	alarm[7] = 60
	hurted = true
	hsp = xscale * movespeed
	
	if sprite_index == spr_knightpepdownslope
		movespeed = 15
	
	if !scr_slope()
		sprite_index = spr_knightpepcharge
	else
		sprite_index = spr_knightpepdownslope
	
	//Bump
	if scr_solid(x + sign(hsp), y) && !place_meeting(x + sign(hsp), y, obj_destructibles)
	&& (!place_meeting(x + sign(hsp), y, obj_slope) or scr_solid_slope(x + sign(hsp), y))
		scr_transfobump();
	
	if movespeed <= 0 && sprite_index == spr_knightpepcharge
		movespeed = 15;
	
	image_speed = 0.4
}

