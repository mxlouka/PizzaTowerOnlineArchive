image_speed = 0.35
playerid = noone
hsp = 0
vsp = 0
grav = 0
dust = 0
index = -1;
xx = x;
yy = y;
sign_id = 0;

// snap to ground
for(var i = 0; i < 20; i++)
{
	if scr_solid(x, y + i + 1)
	{
		y += i;
		break;
	}
}

