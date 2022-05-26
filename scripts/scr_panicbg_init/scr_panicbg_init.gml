function scr_panicbg_init(stop = false)
{
	// Initialize wavy panic background whenever timer starts or room changes
	if !check_shaders()
		exit;
	
	var layers, layernum = 0

	// Check for all layers that exist
	for(var i = 0; i < ds_list_size(global.roombgs); i++)
	{
		var l = global.roombgs[|i];
		if layer_get_depth(l.lay) < 0
			continue;
		layers[layernum++] = layer_get_name(l.lay);
	}
	
	// No backgrounds found
	if !layernum
		exit;
	
	// Change to panic shader on top layer, reset on bottom layer
	var bottom_id = layer_get_id(layers[layernum - 1])
	var top_id = layer_get_id(layers[0])
	layer_script_begin(bottom_id, stop ? -1 : scr_panicbg_start)
	layer_script_end(top_id, stop ? -1 : scr_panicbg_end)
}

