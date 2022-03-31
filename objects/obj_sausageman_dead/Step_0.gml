if hsp == 0
{
	if instance_exists(obj_player)
	{
		var sig = sign(x - obj_player.x);
		if sig == 0
			sig = obj_player.xscale;
	}
	else
		sig = 1;

	hsp = sig * random_range(5, 10);
}
image_xscale = -sign(hsp);

if vsp < 20
	vsp += grav;

x += hsp;
y += floor(vsp);

if sugary
	image_angle += deadrot * image_xscale;
