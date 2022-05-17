function scr_secretdebris(debris = true, blend = c_white)
{
	var hspapply = [0, 0];
	if variable_instance_exists(id, "momentum")
		hspapply = momentum;
	
	var lay_id = get_layer("Tiles_1");
	if lay_id == -1
	{
		map_id = -1;
		data = -1;
	}
	else
	{
		var map_id = layer_tilemap_get_id(lay_id);
		var data = tilemap_get_at_pixel(map_id, x, y);
		if data != -1
			tilemap_set_at_pixel(map_id, tile_set_empty(data), x, y);
	}

	lay_id = get_layer("Tiles_2");
	if lay_id == -1
	{
		map_id2 = -1;
		data2 = -1;
	}
	else
	{
		var map_id2 = layer_tilemap_get_id(lay_id);
		var data2 = tilemap_get_at_pixel(map_id2, x, y);
		if data2 != -1
			tilemap_set_at_pixel(map_id2, tile_set_empty(data2), x, y);
	}
	
	if debris
	{
		repeat 4
		{
			if data2 != 0 && data2 != -1
			{
				with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_secretdebris)
				{
					sprite_index = spr_secretdebris
		            tile_dataid = data2
		            tile_dataset = tilemap_get_tileset(map_id2)
					momentum = hspapply
				}
			}
			else if data != 0 && data != -1
			{
				with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_secretdebris)
				{
					sprite_index = spr_secretdebris
		            tile_dataid = data
		            tile_dataset = tilemap_get_tileset(map_id)
					momentum = hspapply
				}
			}
			else with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
			{
				if blend != c_white
				{
					sprite_index = spr_secretdebris;
					image_blend = blend;
				}
				momentum = hspapply
				image_xscale = abs(other.image_xscale);
				image_yscale = abs(other.image_yscale);
			}
		}
	}
}

function scr_secretbigdebris(debris = true, blend = c_white)
{
	var hspapply = [0, 0];
	if variable_instance_exists(id, "momentum")
		hspapply = momentum;
	
	var lay_id = get_layer("Tiles_1");
	var lay_id2 = get_layer("Tiles_2");
	repeat 2
	{
		if lay_id != -1
		{
			var map_id = layer_tilemap_get_id(lay_id);
			for(var xx = bbox_left; xx <= bbox_right - 32; xx += 32)
			{
				for(var yy = bbox_top; yy <= bbox_bottom - 32; yy += 32)
				{
					var data = tilemap_get_at_pixel(map_id, xx, yy);
					if data != -1
						tilemap_set_at_pixel(map_id, tile_set_empty(data), x, y);
					
					if debris
					{
						if data != 0
						{
							with instance_create(x + sprite_width / 2,y + sprite_height / 2, obj_secretdebris)
							{
								tile_dataid = data
								tile_dataset = tilemap_get_tileset(map_id)
								momentum = hspapply
							}
						}
						else if lay_id2 == -1 or lay_id == lay_id2
						{
							with instance_create(x + sprite_width / 2, y + sprite_height / 2, obj_debris)
							{
								image_xscale = abs(other.image_xscale)
								image_yscale = abs(other.image_yscale)
								
								sprite_index = spr_bigdebris
								if check_sugary()
									sprite_index = spr_bigdebris_ss
								
								if blend != c_white
								{
									sprite_index = spr_secretbigdebris;
									image_blend = blend;
								}
								momentum = hspapply
							}
						}
					}
				}
			}
		}
		lay_id = lay_id2;
	}
}