if live_call() return live_result;

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
draw_set_font(check_sugary() ? global.sugarybigfont : global.bigfont)
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
	var tvx = 832, tvy = 74;
	if !surface_exists(surf)
		surf = surface_create(960, 540);
	surface_set_target(surf);
	draw_clear_alpha(c_black, 0);
	
	var sprit = tvsprite;
	if global.combotime > 0 && tvsprite == spr_tvcombo
	{
		// combo tv
		draw_sprite_ext(scr_sprite_charsuffix(spr_tvcomboclear, sugary ? "ss" : -1), tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
		
		sprit = scr_sprite_charsuffix(spr_tvcombo, sugary ? "ss" : -1);
		draw_sprite_part_ext(sprit, imageindexstore % 5, 0, 0, 16 + (global.combotime / 60) * 148, 177, tvx - sprite_get_xoffset(sprit), tvy - sprite_get_yoffset(sprit), 1, 1, c_white, 1);
		draw_text(tvx + 20, tvy + 1, string(global.combo));
	}
	else if room != Realtitlescreen
	{
		// default ss tv if the equivalent sprite doesn't exist
		sprit = scr_sprite_charsuffix(tvsprite, sugary ? "ss" : -1);
		if sugary && !string_endswith(sprite_get_name(sprit), "_ss")
			sprit = spr_tvdefault_ss;
		
		// tv
		draw_sprite_ext(sprit, tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
		
		// text
		if (tvsprite == spr_tvdefault or sprit == spr_tvdefault_ss) && !global.miniboss
			draw_text(tvx - 4, tvy - 14, string(global.collect));
		if global.miniboss
			draw_text(tvx, tvy - 14, string(global.boxhp));
		if tvsprite == spr_tvdefault
			chose = false;
	}
	draw_set_alpha(1);
	
	// tv frame
	if room != Realtitlescreen && sprit != spr_tvhurt_ss
		draw_sprite_ext(sugary ? spr_tvempty_ss : spr_tvempty, tvimg, tvx, tvy, 1, 1, 0, c_white, 1);
	
	surface_reset_target();
	draw_surface_ext(surf, 0, 0, 1, 1, 0, c_white, alpha);
	
	// image speed
	tvimg += image_speed * sprite_get_speed(sprit);
	tvimg = tvimg % sprite_get_number(sprit);
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
		
		var current_sprite = sprite_get_name(sprite_index);
		var tvoff = string_startswith(current_sprite, "spr_tv_off") or string_startswith(current_sprite, "spr_tv_open");
		if tvoff
			sprite_prev = -1
		else if sprite_prev == -1
			sprite_prev = sprite_index
		
		var offset_x = irandom_range(-collect_shake, collect_shake);
		var offset_y = irandom_range(-collect_shake, collect_shake);
		if sugary
		{
			offset_x -= 1;
			offset_y -= 32 + sin(current_time / 500) * 2;
		}
		
		if room != strongcold_endscreen && room != Realtitlescreen
		{
			// tv
			if sprite_exists(sprite_index)
			{
				var tvspr = sprite_index;
				if sugary && sprite_prev != -1 && idlespr != sprite_prev
				{
					static_timer = 15;
					sprite_prev = idlespr;
				}
				if static_timer > 0
				{
					tvspr = spr_tv_staticSP;
					tvimg += 0.35;
					static_timer--;
				}
				else
					tvimg = image_index;
				
				// apply player palette
				if !tvoff && !string_startswith(current_sprite, "spr_tv_placeholder")
				{
					with obj_player
						pal_swap_set(spr_palette, paletteselect, false);
				}
				
			    draw_sprite_ext(tvspr, tvimg, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				pal_swap_reset();
				
				if !sugary && !tvoff && !(instance_exists(obj_player) && (obj_player.character == "PP" or obj_player.character == "CT"))
					draw_sprite_ext(spr_tv_frame, 0, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				
				if sugary && !tvoff
				{
					var propeller = spr_tvpropeller;
					if tvspr == spr_tv_staticSP
						propeller = spr_tvpropellerstatic;
					
					sugary_propeller += image_speed;
					sugary_propeller = sugary_propeller % sprite_get_number(propeller);
					draw_sprite_ext(propeller, sugary_propeller, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha);
				}
			}
			combo_shake = Approach(combo_shake, 0, 0.25);
			
			// draw combo
			combo_fade = 1;
			if sugary
				combo_fade = min(global.combotime / 5, 1);
			if global.combo != 0 && global.combotime > 0 && !tvoff
			{
				// i fucking hate sugary spire
				if combo_prev < global.combo && sugary
				{
					combo_shake = 5;
					combo_prev = global.combo;
				}
				if !sugary
					combo_prev = global.combo;
				
				var tvcombo = spr_tv_combo;
				if sugary
					tvcombo = spr_tv_comboSP;
				if instance_exists(obj_player) && obj_player.character == "PP"
					tvcombo = spr_tv_comboPP;
				
			    draw_sprite_ext(tvcombo, -1, 833 + offset_x, 107 + offset_y + hud_posY, 1, 1, 0, c_white, alpha * combo_fade)
				
				var str = string(combo_prev);
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
			        draw_text_auto(789 + xx + offset_x + random_range(-combo_shake, combo_shake), 91 - yy + offset_y + hud_posY + random_range(-combo_shake, combo_shake), char,,,combo_fade);
			    }
				
				// sugary combo timer
				if sugary
				{
					if !surface_exists(surf)
						surf = surface_create(112, 32);
					else
					{
						var b = global.combotime / 55;
					
						surface_set_target(surf);
						draw_clear_alpha(c_black, 0);
						draw_sprite_tiled(spr_barpop2_ss, 0, -current_time / 30, 0);
						draw_set_colour(#480028);
						draw_rectangle(112 * b, 0, 112, 32, false);
						draw_sprite(spr_barpop3_ss, 0, 112 * b, 0);
						draw_set_blend_mode(bm_subtract);
						draw_sprite(spr_barpop_ss, 1, 0, 0);
						draw_set_blend_mode(bm_normal);
						surface_reset_target();
					
						draw_set_alpha(combo_fade);
						draw_surface(surf, 833 + offset_x - 73, 107 + offset_y + hud_posY + 34);
						draw_sprite(spr_barpop_ss, 0, 833 + offset_x - 73, 107 + offset_y + hud_posY + 34);
						draw_set_alpha(1);
					}
				}
			}
			else
				combo_prev = 0;
			
			if !sugary
			{
				var barxx = -26;
				var baryy = 30;
				draw_sprite(spr_barpop, 0, 832 + barxx, 250 + baryy);
				var sw = sprite_get_width(spr_barpop);
				var sh = sprite_get_height(spr_barpop);
				var b = global.combotime / 55;
				draw_sprite_part(spr_barpop, 1, 0, 0, sw * b, sh, 832 + barxx, 250 + baryy);
			}
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

