event_inherited();
image_speed = 0;

vsp = random_range(-4, 0);
hsp = random_range(-4, 4);

if !scr_stylecheck(0)
{
	if !scr_stylecheck(2)
		hsp = random_range(-5, 5);
	vsp = random_range(-7, -3);
}

grav = 0.4;
momentum = [0, 0];
image_angle = irandom_range(0, 360);

depth = -1;
alarm[0] = 1;

