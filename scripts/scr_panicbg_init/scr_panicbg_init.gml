function scr_panicbg_init()
{
	// Initialize wavy panic background whenever timer starts or room changes
	if !check_shaders()
		exit;
	
	var layers, layernum = 0

	// Check for all layers that exist
	var l = layer_get_all();
	for (var i = 0; i < array_length(l); i++;)
	{
		var layers_e = layer_get_all_elements(l[i]);
		for (var j = 0; j < array_length(layers_e); j++)
		{
			// backgrounds
			if layer_get_element_type(layers_e[j]) == layerelementtype_background
			{
				if layer_get_depth(l[i]) >= 0
				{
					var bgspr = layer_background_get_sprite(layers_e[j]);
					if bgspr != bg_etbbrick && bgspr != bg_select
						layers[layernum++] = layer_get_name(l[i]);
				}
			}
			break;
		}
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

