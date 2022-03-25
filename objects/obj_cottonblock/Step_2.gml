with obj_player
{
	if place_meeting(x + hsp + xscale, y + vsp + 1, other)
	&& (sprite_index == spr_cotton_attack or sprite_index == spr_cotton_drill)
		instance_destroy(other);
}

if place_meeting(x, y, obj_otherplayer)
	image_alpha = 0.5;
else
	image_alpha = 1;
