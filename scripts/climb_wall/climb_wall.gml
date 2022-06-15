function climb_wall()
{
	var slop = scr_slope();
	
	return (scr_solidwall(x + hsp, y) or scr_solid_slope(x + hsp, y)) 
	&& (!slop or scr_solidwall(x + xscale, y - 10))
	&& (!place_meeting(x + hsp, y, obj_destructibles) or character == "V");
}
