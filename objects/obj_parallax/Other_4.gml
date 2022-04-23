// cottontown generate foreground
var roomname = room_get_name(room);
if string_startswith(roomname, "cotton_") && sugaryspire
{
	for(var i = 0; i < 20; i++)
	{
		if roomname == "cotton_" + string(i) && i < 4
		{
			var l = layer_create(-100, "Backgrounds_steamcc3");
			var l2 = layer_background_create(l, bg_cotton5);
			layer_background_htiled(l2, true);
			array_push(global.roombgs, 
			{
				lay : l,
				bg : l2,
				x : 0,
				y : 0,
				hsp : -0.75,
				vsp : 0,
			});
		}
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

if layer_exists("Assets_1")
&& (room == chateau_7 or string_startswith(room_get_name(room), "grinch_"))
	layer_depth("Assets_1", 95)

if layer_exists("Tiles_1_NEW")
	layer_depth("Tiles_1_NEW", 100)
if layer_exists("Tiles_2_NEW")
	layer_depth("Tiles_2_NEW", 99)
if layer_exists("Tiles_3_NEW")
	layer_depth("Tiles_3_NEW", 98)

