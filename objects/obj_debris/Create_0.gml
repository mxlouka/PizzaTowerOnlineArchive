event_inherited();
image_speed = 0;

vsp = random_range(-4, 0);
hsp = random_range(-4, 4);

if global.gameplay != 0
{
	hsp = random_range(-5, 5);
	vsp = random_range(-10, 10);
}

grav = 0.4;
momentum = [0, 0];
image_angle = irandom_range(0, 360);

depth = -1;
alarm[0] = 1;
