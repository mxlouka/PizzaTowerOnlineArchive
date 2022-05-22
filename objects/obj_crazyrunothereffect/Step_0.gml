if scr_stylecheck(2)
{
	if !instance_exists(ovaries)
	{
		with instance_create(x, y, obj_cloudeffect)
		{
			depth = -99;
			sprite_index = spr_crazyrunothereffect_overlay;
			image_index = other.image_index;
			image_speed = 0.5;
		}
	}
}
else
	depth = -99;

if global.gameplay != 0
	exit;

image_xscale = playerid.xscale
if playerid.movespeed <= 12 && playerid.state != states.faceplant && playerid.state != states.chainsawbump
	instance_destroy()

