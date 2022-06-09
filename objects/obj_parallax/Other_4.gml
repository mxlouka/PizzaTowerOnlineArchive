var roomname = room_get_name(room);

if !string_contains(roomname, "secret")
{
	// change color of entryway effect layer
	if string_startswith(roomname, "entryway_")
	{
		var layerfx = layer_get_fx("Effect_1");
		if layerfx != -1
		{
			if global.panic or room == entryway_11 // nighttime color
				fx_set_parameter(layerfx, "g_TintCol", [216 / 255, 183 / 255, 228 / 255, 1]);
			else // normal sunset color
				fx_set_parameter(layerfx, "g_TintCol", [255 / 255, 221 / 255, 204 / 255, 1]);
		}
	}

	// cottontown generate foreground
	if (string_startswith(roomname, "cotton_") && string_digits(roomname) != "" && real(string_digits(roomname)) < 4)
	or room == cotton_lap
	{
		var l = layer_create(-100, "Backgrounds_FG");
		var l2 = layer_background_create(l, bg_cotton5);
		layer_background_htiled(l2, true);
	
		ds_list_add(global.roombgs, {
			lay : l,
			bg : l2,
			x : 0,
			y : room_height - 540,
			hsp : -0.75,
			vsp : 0,
		});
	}

	// molasses swamp generate foreground
	if (string_startswith(roomname, "molasses_") && string_digits(roomname) != "" && real(string_digits(roomname)) < 7 && roomname != "molasses_6c")
	or room == molasses_lap
	{
		var l = layer_create(-100, "Backgrounds_FG");
		var l2 = layer_background_create(l, bg_molassesfg);
		
		layer_background_htiled(l2, true);
		layer_background_vtiled(l2, true);
		
		ds_list_add(global.roombgs, {
			lay : l,
			bg : l2,
			x : 0,
			y : 200,
			hsp : 0.35,
			vsp : 0,
		});
	}
}

// tile layer depths
if layer_exists("Tiles_1")
	layer_depth("Tiles_1", 100)
if layer_exists("Tiles_2")
	layer_depth("Tiles_2", 99)
if layer_exists("Tiles_3")
	layer_depth("Tiles_3", 98)
if layer_exists("Tiles_4")
	layer_depth("Tiles_4", 97)
if layer_exists("Tiles_5")
	layer_depth("Tiles_5", 96)
if layer_exists("Tiles_6")
	layer_depth("Tiles_6", 95)

if layer_exists("Assets_fg")
	layer_depth("Assets_fg", 90)
