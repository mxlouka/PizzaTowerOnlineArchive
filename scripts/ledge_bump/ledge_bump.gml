function ledge_bump()
{
	// Clip up before bump
	if global.gameplay != 0
	{
		var ht = 33;
		if vsp < 0
			ht = 22;
		
		if (scr_solidwall(x + xscale, y) or scr_solid_slope(x + hsp, y)) && !scr_solid(x + xscale, y - ht)
		{
			vsp = 0;
			
			var yy = 0;
			while scr_solid(x + xscale, y + yy)
				yy--;
			
			y += yy;
			
			if scr_stylecheck(2) with obj_camera
				pancur[1] -= yy;
			return true;
		}
	}
	return false;
}

