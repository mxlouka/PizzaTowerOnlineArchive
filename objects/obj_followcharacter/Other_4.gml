followqueue = [];
lerpx = undefined;
lerpy = undefined;

var target = obj_player;
if instance_exists(target)
{
	followqueue = [target.x + xoffset * (pos - 1), target.y];
	xscale = target.xscale;
	
	if off_on_y
		xoffset = 0;
	else
		xoffset = -xscale * xoffsetmax;
	
	x = followqueue[0];
	y = followqueue[1];
}

