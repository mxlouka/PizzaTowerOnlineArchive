with other
{
	if (scr_transformationcheck() or state == states.tumble) && state != states.gotoplayer && (state != states.bump or grounded) && state != states.backbreaker
	{
		state = states.tumble
		xscale = sign(other.image_xscale)
		movespeed = 14
		sprite_index = spr_tumble
		other.image_index = 0
		other.sprite_index = spr_goblinbot_kick
	}
}

