vsp = random_range(-4, -7);
hsp = 0;

grav = 0.4;
alarm[0] = 5;
cigar = false;
stomped = false;

paletteselect = 0;
spr_palette = -1;
haspalette = false;

sugary = false;
spinspeed = choose(4, 5, 8, 10); // courtesy of pitchmaster's incompetency
scream = -1;

buffer = 10;
if global.gameplay != 0
	vsp = random_range(-10, -18);
d = 255;
