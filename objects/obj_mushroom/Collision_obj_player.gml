if other.vsp > 0 && !other.cutscene && other.state != states.freefall && other.state != states.freefallprep
{
	sprite_index = spr_bounce;
	image_index = 0;
	
	other.endtumble = true;
	if other.state == states.jump or other.state == states.normal
		other.sprite_index = other.spr_machfreefall;
	
	other.vsp = sugary ? -24 : -20
	other.jumpstop = true
}
