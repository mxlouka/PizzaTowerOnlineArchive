function scr_collide_player_pc()
{
	grounded = false
	
	var _hsp = hsp;
	var _vsp = vsp;
	
	// Vertical
	if abs(_vsp) > 0
	{
		repeat abs(_vsp)
		{
			if !scr_solid_pc(x, y + sign(_vsp))
				y += sign(_vsp);
			else
			{
				if vsp >= 0
					grounded |= true;
				vsp = 0;
				break;
			}
		}
	}
	x = floor(x);
		
	// Horizontal
	if abs(_hsp) > 0
	{
		repeat abs(_hsp)
		{
			// Move up slope
			if scr_solid_pc(x + sign(_hsp), y) && !scr_solid_pc(x + sign(_hsp), y - 1)
				y--;
	
			// Move down slope
			if !scr_solid_pc(x + sign(_hsp), y) && !scr_solid_pc(x + sign(_hsp), y + 1) && scr_solid_pc(x + sign(_hsp), y + 2)
				y++;
				
			if !scr_solid_pc(x + sign(_hsp), y)
				x += sign(_hsp);
			else
			{
				hsp = 0;
				break;
			}
		}
	}
	y = floor(y);
	
	grounded |= scr_solid_pc(x, y + 1)
	vsp = min(vsp + grav, 20);
}

function scr_solid_pc(argX, argY)
{
	var old_x = x
	var old_y = y
	var collide = noone;
	var retcol = false;
	
	x = argX;
	y = argY;
	
	// Check if I'm over a tile
	var _solid = instance_place(x, y, obj_solid);
	if _solid
		collide = _solid;
	
	// Check if I crossed a tile boundary and landed on a platform
	if place_meeting(x, y, obj_platform)
	{
		var instlist = ds_list_create();
		var numplat = instance_place_list(x, y, obj_platform, instlist, true);
		
		if y > old_y && bbox_bottom % 16 == 0
		{
			for(var i = numplat - 1; i >= 0; i--)
			{
				var inst = instlist[| i];
				if !place_meeting(x, old_y, inst) && place_meeting(x, y, inst)
				{
					collide = inst;
					break;
				}
			}
		}
		ds_list_destroy(instlist);
	}

	// Check if I'm over a slope
	var slope = instance_place(x, y, obj_slope);
	if slope
	{
		with slope
		{
			var object_side = 0
			var slope_start = 0
			var slope_end = 0
	
			if image_xscale > 0
			{
				// Slope is facing /|
				object_side = other.bbox_right
				slope_start = bbox_bottom
				slope_end = bbox_top
			}
			else
			{
				// Slope is facing |\
				object_side = other.bbox_left
				slope_start = bbox_top
				slope_end = bbox_bottom
			}
		
			// Calculate steepness of slope
			var m = sign(image_xscale) * (bbox_bottom - bbox_top) / (bbox_right - bbox_left)
			var slop = slope_start - round(m * (object_side - bbox_left))
				
			if other.bbox_bottom >= slop
			{
				// Object is inside slope
				collide = id;
			}
		}
	}
	
	x = old_x
	y = old_y
	return (retcol ? collide : instance_exists(collide));
}

