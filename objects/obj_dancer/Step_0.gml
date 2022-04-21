sprite_index = idlespr;
with obj_player
{
	if x != other.x
		other.image_xscale = sign(x - other.x);
}

