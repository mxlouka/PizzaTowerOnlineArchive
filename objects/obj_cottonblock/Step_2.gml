with obj_player
{
	if place_meeting(x + hsp + xscale, y + vsp + 1, other)
	&& (sprite_index == spr_cotton_attack or sprite_index == spr_cotton_drill or sprite_index == spr_cotton_roll or sprite_index == spr_cotton_rollmax or (state == states.cotton && movespeed > 6) or state == states.fireass)
		instance_destroy(other);
}
image_alpha = place_meeting(x, y, obj_otherplayer) ? 0.5 : 1;

