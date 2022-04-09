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
			var _tex_array = texturegroup_get_textures("tg_player");
			for (var i = 0; i < array_length(_tex_array); ++i)
				texture_prefetch(_tex_array[i]);
			
			_tex_array = texturegroup_get_textures("tg_background");
			for (var i = 0; i < array_length(_tex_array); ++i)
				texture_prefetch(_tex_array[i]);
			
			_tex_array = texturegroup_get_textures("tg_baddie");
			for (var i = 0; i < array_length(_tex_array); ++i)
				texture_prefetch(_tex_array[i]);
			
			_tex_array = texturegroup_get_textures("tg_palette");
			for (var i = 0; i < array_length(_tex_array); ++i)
				texture_prefetch(_tex_array[i]);
			
			_tex_array = texturegroup_get_textures("tg_hud");
			for (var i = 0; i < array_length(_tex_array); ++i)
				texture_prefetch(_tex_array[i]);
			
			_tex_array = texturegroup_get_textures("Default");
			for (var i = 0; i < array_length(_tex_array); ++i)
				texture_prefetch(_tex_array[i]);
			
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

