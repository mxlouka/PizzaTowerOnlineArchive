with obj_player
{
	if sprite_index == spr_cotton_attack && place_meeting(x + hsp + xscale, y + vsp, other)
		instance_destroy(other);
}
