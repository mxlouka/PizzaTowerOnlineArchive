function scr_panicbg_init()
{
	// Initialize wavy panic background whenever timer starts or room changes
	if !check_shaders()
		exit;
	
	var layers, layernum = 0

	// Check for all layers that exist
	for(var i = 0; i < array_length(global.roombgs); i++)
	{
		if layer_get_depth(global.roombgs[i].lay) < 0
			continue;
		
		var bgspr = layer_background_get_sprite(global.roombgs[i].bg);
		if bgspr != bg_etbbrick && bgspr != bg_select
			layers[layernum++] = layer_get_name(global.roombgs[i].lay);
	}
	
	// No backgrounds found
	if !layernum
		exit;
	
	// Change to panic shader on top layer, reset on bottom layer
	var bottom_id = layer_get_id(layers[layernum - 1])
	var top_id = layer_get_id(layers[0])
	layer_script_begin(bottom_id, scr_panicbg_start)
	layer_script_end(top_id, scr_panicbg_end)
}

