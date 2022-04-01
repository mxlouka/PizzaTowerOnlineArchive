with obj_player
{
	// mach3 break
	if character != "V"
	&& (place_meeting(x + hsp, y, other) or place_meeting(x + xscale, y, other))
	&& (state == states.mach3 or state == states.knightpepslopes) 
	{
		if scr_stylecheck(2)
			other.hsp2 = hsp / 3;
		instance_destroy(other);
	}
	
	// body slam
	if place_meeting(x, y + 1, other) && ((state == states.freefall && freefallsmash >= 10 && room != etb_7) or state == states.knightpep)
		instance_destroy(other);
}

