vsp = random_range(-5, -10);

if instance_exists(obj_player)
{
	var sig = sign(x - obj_player.x);
	if sig == 0
		sig = obj_player.xscale;
}
else
	sig = 1;

hsp = sig * random_range(5, 10)
if sig != 0
	image_xscale = -sig;

grav = 0.4
alarm[0] = 5
cigar = false
stomped = false

paletteselect = 0
spr_palette = -1
haspalette = false;
