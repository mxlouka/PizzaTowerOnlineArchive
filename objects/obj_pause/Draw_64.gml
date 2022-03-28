if live_call()
	return live_result;

if (pause or pausefad == 2 or pausefad == 4)
{
	if pausefad != 4
		application_surface_draw_enable(true);
	
	// manage fading
	if pausefad == 1 && pausealpha < 1
	{
		pausealpha += 0.2;
		if pausealpha >= 1
		{
			pausefad = 3;
			pausealpha = 0;
		}
		
		draw_sprite_ext(pausebg, 0, 0, 0, 0.5, 0.5, 0, c_white, 1);
		
		draw_set_colour(c_black);
		draw_set_alpha(pausealpha);
		draw_rectangle(0, 0, 960, 540, false);
	}
	if pausefad == 4
	{
		if pausealpha > 0
			pausealpha -= 0.15;
		else
		{
			pausefad = 0;
			if sprite_exists(pausebg)
				sprite_delete(pausebg);
			exit;
		}
		
		draw_set_colour(c_black);
		draw_set_alpha(pausealpha);
		draw_rectangle(0, 0, 960, 540, false);
		draw_set_alpha(1);
	}
	if pausefad == 3
	{
		if pausealpha < 1
			pausealpha += 0.1;
	}
	
	// draw the background
	depth = -9998;
	if pausefad == 3 or pausefad == 2
	{
		draw_set_colour(c_black);
		draw_rectangle(0, 0, 960, 540, false);
		draw_set_colour(make_colour_hsv((257 / 360) * 255, (39 / 100) * 255, (23 / 100) * 255));
		
		var s = 100;
		x = (x + 0.5) % s;
		for(var ii = -1; ii < 960 / s; ii += 1)
		{
			for(var j = -1; j < 540 / s; j += 1)
			{
				if (ii + j) % 2 != 0
					draw_roundrect_ext(ii * s + x, j * s + x, ii * s + s + x - 1, j * s + s + x - 1, 16, 16, false);
			}
		}
		
		if !instance_exists(obj_option)
		{
			draw_set_alpha(1);
			draw_set_colour(c_white);
			draw_set_font(global.bigfont);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			// options
			i += 0.35;
		
			draw_text_auto(960 / 2 , 100, lang_string("pause.continue"),,, selected == 0 ? 1 : 0.5);
			draw_text_auto(960 / 2, 150, lang_string("pause.retry"),,, selected == 1 ? 1 : 0.5);
			draw_text_auto(960 / 2, 200, lang_string("pause.exit"),,, selected == 2 ? 1 : 0.5);
			draw_text_auto(960 / 2, 250, lang_string("pause.options"),,, selected == 3 ? 1 : 0.5);
			draw_sprite(spr_cursor, i, 960 / 2 - 42, 116 + 50 * selected);
			
			// player
			var _pspr = spr_player_idle;
			var _ppanic = global.panic or global.snickchallenge;
			
			switch character
			{
				default:
				case "P":
					var _spr_resume = _ppanic ? spr_player_panic : spr_player_idle;
					var _spr_options = spr_file1;
					var _spr_retry = _ppanic ? spr_player_hurtidle : spr_player_mach;
					var _spr_exit = spr_player_winding;
					var _spr_palette = spr_peppalette;
					break;
				
				case "N":
					_spr_resume = _ppanic ? spr_playerN_panicidle : spr_playerN_idle;
					_spr_options = spr_playerN_rageidle;
					_spr_retry = _ppanic ? spr_playerN_hurtidle : spr_playerN_mach;
					_spr_exit = spr_playerN_winding;
					_spr_palette = spr_noisepalette;
					break;
				
				case "SP":
					_spr_resume = _ppanic ? spr_playerSP_panic : spr_playerSP_idle;
					_spr_options = spr_playerSP_deez;
					_spr_retry = _ppanic ? spr_playerSP_3hpidle : spr_playerSP_mach4;
					_spr_exit = spr_playerSP_winding;
					_spr_palette = spr_pizzpalette;
					break;
				
				case "PP":
					_spr_resume = _ppanic ? spr_playerPP_panic : spr_playerPP_idle;
					_spr_options = spr_playerPP_gottreasure;
					_spr_retry = _ppanic ? spr_playerPP_3hpidle : spr_playerPP_mach;
					_spr_exit = spr_playerPP_winding;
					_spr_palette = spr_pizzpalette;
					break;
					
				case "V":
					_spr_resume = _ppanic ? spr_playerV_panic : spr_playerV_idle;
					_spr_options = spr_playerV_crouch;
					_spr_retry = _ppanic ? spr_playerV_angryidle : spr_playerV_crazyrun;
					_spr_exit = spr_playerV_winding;
					_spr_palette = spr_vigipalette;
					break;
				
				case "S":
					var _spr_resume = _ppanic ? spr_snick_idle : spr_snick_idle;
					var _spr_options = spr_snick_idleanim;
					var _spr_retry = _ppanic ? spr_snick_superpeelout : spr_snick_mach3;
					var _spr_exit = spr_snick_bump;
					var _spr_palette = spr_snickpalette;
					break;
			}
			
			switch selected
			{
				case 0: _pspr = _spr_resume; break;
				case 1: _pspr = _spr_retry; break;
				case 2: _pspr = _spr_exit; break;
				case 3: _pspr = _spr_options; break;
			}
			
			pal_swap_set(_spr_palette, paletteselect, false);
			draw_sprite_ext(_pspr, i, 200, 200, 2, 2, 0, c_white, 1);
			pal_swap_reset();
			
			// pizza
			var hud_xx = 750, hud_yy = 450;
			var sugary = (character == "SP" or character == "SN");
			draw_sprite_ext(sugary ? spr_candyscore : spr_pizzascore, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
			
			var _score = global.collect;
			if !sugary
			{
			    if _score >= global.crank
			        draw_sprite_ext(spr_pizzascore_pepper, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
			    if _score >= global.brank
			        draw_sprite_ext(spr_pizzascore_pepperoni, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
			    if _score >= global.arank
			        draw_sprite_ext(spr_pizzascore_olive, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
			    if _score >= global.srank
			        draw_sprite_ext(spr_pizzascore_shroom, 0, hud_xx, hud_yy, 1, 1, 0, c_white, 1);
			}
			
			draw_set_valign(fa_top);
		    draw_set_halign(fa_left);
		    draw_set_font(sugary ? global.candyfont : global.collectfont);
			
		    var str = string(_score);
		    var num = string_length(str);
		    var xx = hud_xx - string_width(str) / 2;
			
		    draw_set_alpha(1);
		    for (var ii = 0; ii < num; ii++)
		    {
		        var yy = (ii + 1) % 2 == 0 ? -5 : 0;
		        draw_text(xx, hud_yy - 56 + yy, string_char_at(str, ii + 1));
		        xx += string_width(str) / num;
		    }
			
			draw_set_alpha(1);
		    pal_swap_reset();
			
			// toppins
			draw_sprite_ext(check_sugary() ? spr_toppinmallow_NEW : spr_toppinshroom_NEW, i, 92, 420, 1, 1, 0, c_white, global.shroomfollow ? 1 : 0.25);
			draw_sprite_ext(check_sugary() ? spr_toppinchoco : spr_toppincheese_NEW, i, 92 + (50 * 1), 420, 1, 1, 0, c_white, global.cheesefollow ? 1 : 0.25);
			draw_sprite_ext(check_sugary() ? spr_toppincrack : spr_toppintomato_NEW, i, 92 + (50 * 2), 420, 1, 1, 0, c_white, global.tomatofollow ? 1 : 0.25);
			draw_sprite_ext(check_sugary() ? spr_toppinworm : spr_toppinsausage_NEW, i, 92 + (50 * 3), 420, 1, 1, 0, c_white, global.sausagefollow ? 1 : 0.25);
			draw_sprite_ext(check_sugary() ? spr_toppincandy : spr_toppinpineapple_NEW, i, 92 + (50 * 4), 420, 1, 1, 0, c_white, global.pineapplefollow ? 1 : 0.25);
			
			// fade
			draw_set_colour(c_black);
			draw_set_alpha(1 - clamp(pausealpha, 0, 1));
			draw_rectangle(0, 0, 960, 540, false);
		}
		else
			depth = -90;
	}
	else
		x = 0;
	
	if pausefad == 2
	{
		pausealpha -= 0.2;
		if pausealpha <= 0
		{
			pausealpha = 1;
			pausefad = 4;
		}
	}
	draw_set_alpha(1);
}
else
{
	if surface_exists(pausesurf)
		surface_free(pausesurf);
}
