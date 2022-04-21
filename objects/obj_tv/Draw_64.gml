// snick rematch vignette
if ((room == dungeon_10 or room == dungeon_9 or room == snick_challengeend) && global.snickchallenge && global.snickrematch)
{
    draw_sprite_ext(spr_vignette, 0, 0, 0, 1, 1, 0, c_white, random_range(0.8, 0.9));
    instance_destroy(obj_baddie, false);
    instance_destroy(obj_baddiespawner, false);
}

// snick rematch jumpscare
if jumpscare > -1
{
    jumpscare--;
	
    if irandom(2) == 0
        jumpscareimage = irandom(sprite_get_number(spr_scares) - 1);
	
    if jumpscare <= 5
        draw_sprite(spr_scares_txt, jumpscaretext, 0, 0);
    else
        draw_sprite(spr_scares, jumpscareimage, 0, 0);
}

if room == rm_deltarune or room == rm_darkreveal or !global.showhud
	exit;

// Draw Text
draw_set_font(global.bigfont)
draw_set_halign(fa_center);
draw_set_color(c_white)

// Text Event
draw_set_valign(fa_bottom);
draw_text_auto(xi, yi, string(message))
draw_set_valign(fa_top);

draw_set_font(global.bigfont)

#region old hud

if global.gameplay == 0
{
	//Draw TV
	if global.combotime > 0 && tvsprite == spr_tvcombo
	{
		if !surface_exists(surf)
			surf = surface_create(960, 540);
		
		surface_set_target(surf);
		draw_clear_alpha(c_black, 0);
		
		draw_sprite_ext(scr_sprite_charsuffix(spr_tvcomboclear, sugary ? "ss" : -1), -1, 832, 74, 1, 1, 0, c_white, 1);
		
		var sprit = scr_sprite_charsuffix(spr_tvcombo, sugary ? "ss" : -1);
		draw_sprite_part_ext(sprit, imageindexstore % 5, 0, 0, 16 + (global.combotime / 60) * 148, 177, 832 - sprite_get_xoffset(sprit), 74 - sprite_get_yoffset(sprit), 1, 1, c_white, 1);
		surface_reset_target();
		
		draw_surface_ext(surf, 0, 0, 1, 1, 0, c_white, alpha);
		draw_text(852, 75, string(global.combo));
	}
	else if room != strongcold_endscreen && room != Realtitlescreen
	{
		// default ss tv if the equivalent sprite doesn't exist
		var sprit = scr_sprite_charsuffix(tvsprite, sugary ? "ss" : -1);
		if sugary && !string_endswith(sprite_get_name(sprit), "_ss")
			sprit = spr_tvdefault_ss;
		
		// tv frame
		draw_sprite_ext(sprit, -1, 832, 74, 1, 1, 0, c_white, alpha);
		
		// text
		if (tvsprite == spr_tvdefault or sprit == spr_tvdefault_ss) && !global.miniboss
			draw_text(828, 60, string(global.collect));
		if global.miniboss
			draw_text(832, 60, string(global.boxhp));
		if tvsprite == spr_tvdefault
			chose = false;
	}
}

#endregion
#region new hud

else
{
	if !(instance_exists(obj_player) && obj_player.state == states.rotate)
	{
		/*
		if global.use_temperature
		{
		    var _width = sprite_get_width(spr_temperature_meterfill)
		    var _height = sprite_get_height(spr_temperature_meterfill)
		    global.temperature += global.temperature_spd
		    global.temperature = clamp(global.temperature, 0, (global.temp_thresholdnumber * 100))
		    var _tmp = (global.temperature / (global.temp_thresholdnumber * 100))
		    var _top = 0
		    var _height2 = (_height * _tmp)
		    draw_sprite_part_ext(spr_temperature_meterfill, 0, 0, _top, _width, _height2, 864, (192 + _height), 1, -1, c_white, 1)
		    draw_sprite(spr_temperature_meter, 0, 864, 192)
		}
		*/
		
		var offset_x = irandom_range(-collect_shake, collect_shake);
		var offset_y = irandom_range(-collect_shake, collect_shake);
		if sugary
		{
			offset_x -= 1;
			offset_y -= 33;
		}
		
		if room != strongcold_endscreen && room != Realtitlescreen
		{
			// tv
			if sprite_exists(sprite_index)
			{
				// apply player palette
				var tempvar = sprite_index != spr_tv_placeholder && sprite_index != spr_tv_placeholderSP && sprite_index != spr_tv_placeholderPP
				&& sprite_index != spr_tv_off && sprite_index != spr_tv_offSP && sprite_index != spr_tv_offPP
				&& sprite_index != spr_tv_open && sprite_index != spr_tv_openSP && sprite_index != spr_tv_openPP;
				
				if tempvar
				{
					with obj_player
						pal_swap_set(spr_palette, paletteselect, false);
				}
				
			    draw_sprite_ext(sprite_index, -1, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				pal_swap_reset();
				
				if !sugary && tempvar && !(instance_exists(obj_player) && (obj_player.character == "PP" or obj_player.character == "CT"))
					draw_sprite_ext(spr_tv_frame, -1, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
			}
			
			// draw combo
			if global.combo != 0 && global.combotime > 0
			&& sprite_index != spr_tv_open && sprite_index != spr_tv_off && sprite_index != spr_tv_openSP && sprite_index != spr_tv_offSP && sprite_index != spr_tv_openPP && sprite_index != spr_tv_offPP
			{
				var tvcombo = spr_tv_combo;
				if sugary
					tvcombo = spr_tv_comboSP;
				if instance_exists(obj_player) && obj_player.character == "PP"
					tvcombo = spr_tv_comboPP;
				
			    draw_sprite_ext(tvcombo, -1, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha)
				
				var str = string(global.combo);
			    if global.combo < 10 && global.combo > -1
			        str = "0" + str;
				
			    draw_set_halign(fa_left);
			    draw_set_valign(fa_top);
			    draw_set_font(global.combofont);
			    var num = string_length(str);
			    var w = round(string_width(str) / num);
			    for (var i = 0; i < num; i++)
			    {
			        var char = string_char_at(str, i + 1);
			        var xx = i * w, yy = i * 5;
			        draw_text(789 + xx + offset_x, 91 - yy + offset_y + hud_posY, char);
			    }
			}
		
			var barxx = -26;
			var baryy = 30;
			draw_sprite(spr_barpop, 0, 832 + barxx, 250 + baryy);
			var sw = sprite_get_width(spr_barpop);
			var sh = sprite_get_height(spr_barpop);
			var b = global.combotime / 55;
			draw_sprite_part(spr_barpop, 1, 0, 0, sw * b, sh, 832 + barxx, 250 + baryy);
		}
	
		if bubblespr != noone
		    draw_sprite_ext(bubblespr, bubbleindex, 512 - (sugary * 65), 53 + hud_posY, 1, 1, 1, c_white, alpha);
	
		if !surface_exists(promptsurface)
		    promptsurface = surface_create(290, 102);
		
		surface_set_target(promptsurface)
		draw_clear_alpha(c_black, 0) 
		draw_set_font(font1)
		draw_set_halign(fa_left)
		draw_set_valign(fa_middle)
		
		// draw bubble
		if bubblespr == spr_tv_bubble
		{
		    promptx -= promptspd;
		    if bubblespr != spr_tv_bubbleclose && promptx < 350 - string_width(prompt)
		    {
		        bubblespr = spr_tv_bubbleclose;
		        bubbleindex = 0;
				promptx = promptxstart;
		    }
		    draw_text_color(promptx - 350, 50, prompt, c_black, c_black, c_black, c_black, 1);
		}
		
		draw_set_halign(fa_left);
		surface_reset_target();
		draw_surface(promptsurface, 350 - (sugary * 65), hud_posY);
	}
	
	draw_set_font(global.bigfont)
}

#endregion

// pizzacoin in the hub
draw_set_valign(fa_top);
if check_online() && room == hub_room1 && !(instance_exists(obj_player) && obj_player.state == states.victory)
{
	draw_set_halign(fa_right);
	pizzacoinframe = (pizzacoinframe + 0.35) % sprite_get_number(spr_pizzacoin);
	
	if scr_getcoin() < 0
		draw_set_colour(c_red);
	
	draw_text(960 - 64 - 32, 148 + (global.gameplay != 0 ? (64 + (sugary ? 16 : 0)) : 0), string(scr_getcoin()));
	draw_sprite_ext(spr_pizzacoin, pizzacoinframe, 960 - 64 - 24, 148 + (global.gameplay != 0 ? (64 + (sugary ? 16 : 0)) : 0), 1, 1, 0, c_white, alpha);
	
	draw_set_halign(fa_center);
}
draw_set_colour(c_white);

// golf hits
if instance_exists(obj_pizzaballOLD)
or instance_exists(obj_pizzaball)
{
	draw_set_halign(fa_right);
	draw_text(960 - 25, 200, string(string(global.golfhit) + " " + (global.golfhit == 1 ? "GOLF HIT" : "GOLF HITS")))
	draw_set_halign(fa_center);
}
	
