/// @description ranks & level appearance
switch room
{
	// please redo some of these specially the old level ones
	case entrance_1: global.srank = 11500; break;
	case medieval_1: global.srank = 8300; break;
	case chateau_1: global.srank = 9300; break;
	case ruin_1: global.srank = 11200; break;
	case ufo_1: global.srank = 10950; break;
	case floor1_room0: global.srank = 13400; break; // desert
	case floor2_room9: global.srank = 10000; break; // mansion
	case floor3_room0: global.srank = 6500; break; // factory
	case floor4_room0: global.srank = 5800; break; // sewer
	case floor5_room1: global.srank = 7800; break; // freezer
	case golf_room1: global.srank = (scr_stylecheck(1) ? 3200 : 4500); break;
	case farm_1: global.srank = 10300; break;
	case graveyard_1: case graveyard_1_NEW: global.srank = 11855; break;
	case dungeon_1: global.srank = 10300; break;
	case strongcold_10: global.srank = 9000; break;
	case dragonlair_1: global.srank = 4500; break;
	case forest_1: global.srank = 14000; break;
	case beach_1: global.srank = 14000; break;
	case etb_1: global.srank = 7000; break;
	case grinch_1: global.srank = 6400; break;
	case kungfu_1: global.srank = 15000; break;
}
if global.snickchallenge
	global.srank = 10300;

// calculate lesser ranks
if room == custom_lvl_room
	alarm[1] = 4;
else
{
	global.arank = global.srank - global.srank / 4;
	global.brank = global.srank - global.srank / 4 * 2;
	global.crank = global.srank - global.srank / 4 * 3;
}

// change snick rematch appearance
var layers = layer_get_all();
for (var i = 0; i < array_length(layers); i++;)
{
	var layers_e = layer_get_all_elements(layers[i]);
	for (var j = 0; j < array_length(layers_e); j++)
	{
		// repaint sprites
		if repaintjokebuild
		{
			if layer_get_element_type(layers_e[j]) == layerelementtype_sprite
			{
				var getch = asset_get_index(sprite_get_name(layer_sprite_get_sprite(layers_e[j])) + "_PP");
				if sprite_exists(getch)
					layer_sprite_change(layers_e[j], getch);
				continue;
			}
			else
				break;
		}
		
		if global.snickrematch
		{
			// backgrounds
			if layer_get_element_type(layers_e[j]) == layerelementtype_background
			{
				var getch = asset_get_index(sprite_get_name(layer_background_get_sprite(layers_e[j])) + "_re");
				if sprite_exists(getch)
					layer_background_sprite(layers_e[j], getch);
				break;
			}
			// tiles
			else if layer_get_element_type(layers_e[j]) == layerelementtype_tilemap
			{
				var getch = asset_get_index(tileset_get_name(tilemap_get_tileset(layers_e[j])) + "_re");
				if getch != -1
					tilemap_tileset(layers_e[j], getch);
				break;
			}
			// assets
			else if layer_get_element_type(layers_e[j]) == layerelementtype_sprite
			{
				var getch = asset_get_index(sprite_get_name(layer_sprite_get_sprite(layers_e[j])) + "_re");
				if sprite_exists(getch)
					layer_sprite_change(layers_e[j], getch);
			}
			else
				break;
		}
		else if global.panic
		{
			if layer_get_element_type(layers_e[j]) == layerelementtype_background
			&& layer_background_get_sprite(layers_e[j]) == bg_farm2
				layer_hspeed(layers[i], -2);
		}
		else
			break;
	}
}

// make solids visible and stuff
if (string_startswith(room_get_name(room), "ancient_")) or (string_startswith(room_get_name(room), "cotton_"))
{
	var hastiles = false;
	for (var i = 0; i < array_length(layers); i++;)
	{
		if string_startswith(layer_get_name(layers[i]), "Tiles_")
		{
			hastiles = true;
			break;
		}
	}
	
	if !hastiles
	{
		// make backgrounds higher depth
		for (var i = 0; i < array_length(layers); i++;)
		{
			if string_startswith(layer_get_name(layers[i]), "Backgrounds_")
				layer_depth(layers[i], layer_get_depth(layers[i]) + 500);
		}
		
		// make some invisible stuff visible
		with obj_solid
			visible = true;
		with obj_slope
			visible = true;
		with obj_platform
			visible = true;
		with obj_secretblock
			visible = true;
		with obj_secretbigblock
			visible = true;
		with obj_secretmetalblock
			visible = true;
	}
}

// i dont even know if i use this
if layer_exists("Tiles_1_NEW")
{
	if global.gameplay == 0
		layer_destroy("Tiles_1_NEW");
	else
		layer_destroy("Tiles_1");
}
