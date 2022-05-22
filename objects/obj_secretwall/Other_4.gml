mylayer = layer_get_id("Tiles_Secret");
if layer_exists(mylayer)
{
	layer_depth(mylayer, 90);
	layer_shader(mylayer, shd_layeralpha);
}

if place_meeting(x, y, obj_player)
{
	alpha = 0;
	done = true;
}
else if oneway
{
	with instance_create(x, y, obj_solid)
	{
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
	}
}

