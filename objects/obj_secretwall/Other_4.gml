mylayer = layer_get_id("Tiles_Secret");
if layer_exists(mylayer)
{
	layer_depth(mylayer, 90);
	layer_shader(mylayer, shd_layeralpha);
}

