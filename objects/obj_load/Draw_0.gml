draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_font(loadfont);

switch loadwhat
{
	default:
		draw_text(960 / 2, 540 / 2, lang_string("load.loading"));
		break;
	
	case 0:
		draw_text(960 / 2, 540 / 2, lang_string("load.txgrp"));
		if prog < 0
			prog++;
		else
		{
			// load texture groups
			function load_tg(tgname)
			{
				var _tex_array = texturegroup_get_textures(tgname);
				for (var i = 0; i < array_length(_tex_array); ++i)
					texture_prefetch(_tex_array[i]);
			}
			
			load_tg("tg_player");
			load_tg("tg_background");
			load_tg("tg_baddie");
			load_tg("tg_palette");
			load_tg("tg_hud");
			load_tg("tg_danceroom");
			load_tg("Default");
			
			loadwhat = 2;
		}
		break;
	
	case 1:
		// load audio groups
		for (var i = 1; audio_group_name(i) != undefined; i++)
		{
			if !audio_group_is_loaded(i)
			{
				if !audio_group_load(i)
					show_error("Audio group " + audio_group_name(i) + " is missing!", true);
			}
		}
		loadwhat = 2;
		break;
	
	case 2:
		loadwhat = -1;
		alarm[1] = 2;
		break;
}

