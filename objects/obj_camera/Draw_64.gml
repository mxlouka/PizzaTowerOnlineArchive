//Draw
if room == Realtitlescreen or room == rm_deltarune or room == rm_darkreveal or !drawhud or !global.showhud
	exit;

var sugary = false;
with obj_player
	if (character == "SP" or character == "SN") sugary = true;

var showhud = !instance_exists(obj_player) or (obj_player.state != states.rotate && obj_player.state != states.gameover);
if global.pizzadelivery && global.hp > 0
	draw_sprite(spr_pizzahealthbar, 8 - global.hp, (global.gameplay == 0 ? 190 : 100) + healthshake, (global.gameplay == 0 ? 70 : 240) + hud_posY + healthshake)

#region old hud

if global.gameplay == 0
{
	hud_posY = 0;
	
	//Backup Weapon
	if instance_exists(obj_player) && obj_player.backupweapon
		draw_sprite_ext(spr_shotgunbackup, -1, 50, 100, 1, 1, 0, c_white, alpha)
	
	if instance_exists(obj_player) && obj_player.state != states.gameover
	{
		var _state = obj_player.state;
		if _state == states.backbreaker
			_state = obj_player.storedstate;
		if _state == states.hitlag
			_state = obj_player.tauntstoredstate;
		
		var hudface = -1;
		if obj_player.character == "V"
		{
			if (healthshaketime > 0 && playerhealthup) or obj_player.sprite_index == spr_playerV_keydoor or _state == states.keyget or _state == states.gottreasure 
				hudface = spr_playerV_happyHUD
			else if _state == states.mach1 or _state == states.mach2 or _state == states.mach3 or _state == states.machslide or _state == states.machroll
				hudface = spr_playerV_machHUD
			else if (healthshaketime > 0 && !playerhealthup) or _state = states.hurt
				hudface = spr_playerV_hurtHUD
			else if global.panic = true
				hudface = spr_playerV_panicHUD
			else if obj_player.angry
				hudface = spr_playerV_angryHUD
			else
				hudface = spr_playerV_normalHUD
		}

		if obj_player.character == "P"
		{
			if obj_player.sprite_index = spr_knightpep_thunder
				hudface = spr_pepinoHUDthunder
			else if obj_player.sprite_index != spr_knightpep_start && (_state = states.knightpep or _state = states.knightpepslopes)
				hudface = spr_pepinoHUDknight
			else if obj_player.sprite_index = spr_bombpep_end
				hudface = spr_pepinoHUDbombend
			else if instance_exists(obj_itspizzatime)  or obj_player.sprite_index = spr_bombpep_intro or obj_player.sprite_index = spr_bombpep_runabouttoexplode or obj_player.sprite_index = spr_bombpep_run or obj_player.sprite_index = spr_player_fireass
				hudface = spr_pepinoHUDscream
			else if _state = states.Sjumpland or (_state = states.freefallland && shake_mag > 0)  
				hudface = spr_pepinoHUDstun
			else if obj_player.sprite_index = spr_player_victory or _state = states.keyget or _state = states.smirk or _state = states.gottreasure or (_state = states.bossintro &&  obj_player.sprite_index = spr_player_levelcomplete)
				hudface = spr_pepinoHUDhappy
			else if obj_player.sprite_index = spr_player_machroll or obj_player.sprite_index = spr_player_tumble
				hudface = spr_pepinoHUDrolling
			else if obj_player.supercharged
				hudface = spr_pepinoHUDmenacing
			else if _state = states.mach1  or _state = states.chainsaw or _state = states.freefallprep or _state = states.freefall or  _state = states.tackle or _state = states.Sjump or _state = states.slam or  _state = states.Sjumpprep or _state = states.grab or _state = states.punch or _state = states.backbreaker or _state = states.backkick or _state = states.uppunch or _state = states.shoulder
				hudface = spr_pepinoHUDmach1
			else if _state = states.mach2 or obj_player.sprite_index = spr_player_dive or obj_player.sprite_index = spr_player_machslideboost or _state = states.climbwall or _state = states.handstandjump or _state = states.superslam 
				hudface = spr_pepinoHUDmach2
			else if _state = states.mach3 && obj_player.sprite_index = spr_player_crazyrun 
				hudface = spr_pepinoHUDmach4
			else if _state = states.mach3 or obj_player.sprite_index = spr_player_machslideboost3
				hudface = spr_pepinoHUDmach3
			else if _state = states.hurt or obj_player.sprite_index = spr_bombpep_end or obj_player.sprite_index = spr_player_fireassend or _state = states.timesup or _state = states.bombpep or (_state = states.bossintro &&  obj_player.sprite_index = spr_player_bossintro) or (_state = states.bossintro &&  obj_player.sprite_index = spr_player_idle)
				hudface = spr_pepinoHUDhurt
			else if obj_player.angry
				hudface = spr_pepinoHUD3hp
			else if obj_player.sprite_index = spr_player_hurtidle or obj_player.sprite_index = spr_player_hurtwalk
				hudface = spr_pepinoHUD1hp
			else if global.panic = true or global.snickchallenge = true or global.miniboss = true
				hudface = spr_pepinoHUDpanic
			else if obj_player.sprite_index = spr_shotgun_pullout
				hudface = spr_pepinoHUDmenacing
			else
				hudface = spr_pepinoHUD
		}

		if obj_player.character == "S"
		{
			if _state = states.hurt
				hudface = spr_snickHUDhurt
			else
				hudface = spr_snickHUD
		}

		if obj_player.character == "N"
		{
			if scr_checkskin(checkskin.n_nose)
			{
				hudface = spr_noiseHUD_idle;
				hudframe = 0;
			}
			else
			{
				if obj_player.sprite_index = obj_player.spr_knightpepthunder
					hudface = spr_noiseHUD_thunder
				else if obj_player.sprite_index != obj_player.spr_knightpepstart && (_state = states.knightpep or _state = states.knightpepslopes)
					hudface = spr_noiseHUD_knight
				else if obj_player.sprite_index = obj_player.spr_bombpepend
					hudface = spr_noiseHUD_bomb
				else if instance_exists(obj_itspizzatime)  or obj_player.sprite_index = obj_player.spr_bombpepintro or obj_player.sprite_index = obj_player.spr_bombpeprunabouttoexplode or obj_player.sprite_index = obj_player.spr_bombpeprun or obj_player.sprite_index = obj_player.spr_fireass
					hudface = spr_noiseHUD_panic
				else if _state = states.Sjumpland or (_state = states.freefallland && shake_mag > 0)  
					hudface = spr_noiseHUD_groundpound
				//else if obj_player.sprite_index = obj_player.spr_victory or _state = states.keyget or _state = states.smirk or _state = states.gottreasure or (_state = states.bossintro &&  obj_player.sprite_index = obj_player.spr_player_levelcomplete)
				//	hudface = spr_noiseHUD_happy
				else if obj_player.supercharged
					hudface = spr_noiseHUD_menacing
				else if _state = states.mach1  or _state = states.chainsaw or _state = states.freefallprep or _state = states.freefall or  _state = states.tackle or _state = states.Sjump or _state = states.slam or  _state = states.Sjumpprep or _state = states.grab or _state = states.punch or _state = states.backbreaker or _state = states.backkick or _state = states.uppunch or _state = states.shoulder
					hudface = spr_noiseHUD_mach1
				else if _state = states.pogo or _state = states.mach2 or obj_player.sprite_index == obj_player.spr_dive or obj_player.sprite_index = obj_player.spr_machslideboost or _state = states.climbwall or _state = states.handstandjump or _state = states.superslam 
					hudface = spr_noiseHUD_mach2
				else if _state = states.mach3 && obj_player.sprite_index == obj_player.spr_crazyrun 
					hudface = spr_noiseHUD_crazyrun
				else if _state = states.mach3 or obj_player.sprite_index == obj_player.spr_mach3boost
					hudface = spr_noiseHUD_mach3
				//else if _state = states.hurt or obj_player.sprite_index = obj_player.spr_bombpepend or obj_player.sprite_index = obj_player.spr_fireassend or _state = states.timesup or _state = states.bombpep or (_state = states.bossintro &&  obj_player.sprite_index = obj_player.spr_player_bossintro) or (_state = states.bossintro &&  obj_player.sprite_index = obj_player.spr_idle)
				//	hudface = spr_noiseHUD_hurt
				else if obj_player.angry
					hudface = spr_noiseHUD_angry
				else if obj_player.sprite_index == obj_player.spr_hurtidle or obj_player.sprite_index == obj_player.spr_hurtwalk
					hudface = spr_noiseHUD_lowhealth
				else if global.panic or global.snickchallenge or global.miniboss
					hudface = spr_noiseHUD_panic
				else if obj_player.sprite_index == obj_player.spr_shotgunpullout
					hudface = spr_noiseHUD_menacing
				else
					hudface = spr_noiseHUD_idle
			}
		}
	
		if obj_player.character == "SP"
		{
			if obj_player.sprite_index == obj_player.spr_knightpepthunder
				hudface = spr_pizzyHUDthunder
			else if obj_player.sprite_index != obj_player.spr_knightpepstart && (_state == states.knightpep or _state == states.knightpepslopes or _state == states.knightpepattack)
				hudface = spr_pizzyHUDknight
			else if obj_player.sprite_index == obj_player.spr_bombpepend
				hudface = spr_pizzyHUDbombend
			else if instance_exists(obj_itspizzatime) or obj_player.sprite_index == obj_player.spr_bombpepintro or obj_player.sprite_index == obj_player.spr_bombpeprunabouttoexplode or obj_player.sprite_index == obj_player.spr_bombpeprun or obj_player.sprite_index == obj_player.spr_fireass
				hudface = spr_pizzyHUD_panic // REPLACE
			else if _state = states.Sjumpland or (_state == states.freefallland && shake_mag > 0)  
				hudface = spr_pizzyHUDstun
			else if obj_player.sprite_index = obj_player.spr_victory or _state = states.keyget or _state = states.smirk or _state = states.gottreasure or (_state = states.bossintro && obj_player.sprite_index = spr_player_levelcomplete)
				hudface = spr_pizzyHUDhappy
			//else if obj_player.sprite_index == obj_player.spr_machroll or obj_player.sprite_index == obj_player.spr_tumble
			//	hudface = spr_pepinoHUDrolling
			else if global.combo >= 3
				hudface = spr_pizzyHUDmenacing
			else if _state == states.mach1 or _state == states.tackle or _state == states.slam or _state == states.grab or _state == states.punch or _state == states.backkick or _state == states.uppunch or _state == states.shoulder
				hudface = spr_pizzyHUDmach1
			else if _state == states.mach2/* or obj_player.sprite_index = obj_player.spr_dive*/ or _state == states.machroll or obj_player.sprite_index == obj_player.spr_machslideboost or _state = states.climbwall or _state = states.handstandjump or _state = states.superslam or _state == states.freefallprep
				hudface = spr_pizzyHUDmach2
			else if _state == states.mach3 && obj_player.sprite_index == obj_player.spr_crazyrun
				hudface = spr_pizzyHUDmach4
			else if _state == states.mach3 or obj_player.sprite_index == obj_player.spr_mach3boost
				hudface = spr_pizzyHUDmach3
			else if _state == states.hurt or obj_player.sprite_index == obj_player.spr_fireassend or _state = states.timesup or _state = states.bombpep or (_state = states.bossintro &&  obj_player.sprite_index = obj_player.spr_bossintro) or (_state = states.bossintro &&  obj_player.sprite_index = obj_player.spr_idle)
				hudface = spr_pizzyHUDhurt
			else if obj_player.sprite_index == obj_player.spr_bombpepend
				hudface = spr_pizzyHUDbombend
			else if _state == states.Sjumpprep
				hudface = spr_pizzyHUDsuperjumpprep
			else if _state == states.Sjump
				hudface = spr_pizzyHUDsuperjump
			else if _state == states.freefall
				hudface = spr_pizzyHUDbodyslam
			else if obj_player.sprite_index = obj_player.spr_bombpepend
				hudface = spr_pizzyHUDbombend
			else if _state == states.bump
				hudface = spr_pizzyHUDbump
			else if obj_player.angry
				hudface = spr_pizzyHUD3hp
			else if obj_player.sprite_index == obj_player.spr_hurtidle or obj_player.sprite_index == obj_player.spr_hurtwalk // REPLACE
				hudface = spr_pizzyHUDhurt // REPLACE
			else if global.panic or global.snickchallenge or global.miniboss
				hudface = spr_pizzyHUD // REPLACE 
			else if obj_player.sprite_index == obj_player.spr_shotgunpullout
				hudface = spr_pizzyHUDmenacing
			else if _state == states.cotton
				hudface = spr_pizzyHUDcotton
			else
				hudface = spr_pizzyHUD;
		}
		
		if obj_player.character == "PP"
		{
			if obj_player.sprite_index == obj_player.spr_knightpepthunder
				hudface = spr_pissinoHUD_thunder
			else if obj_player.sprite_index != obj_player.spr_knightpepstart && (_state == states.knightpep or _state == states.knightpepslopes or _state == states.knightpepattack)
				hudface = spr_pissinoHUD_knight
			else if obj_player.sprite_index == obj_player.spr_bombpepend
				hudface = spr_pissinoHUD_bombend
			else if instance_exists(obj_itspizzatime) or obj_player.sprite_index == obj_player.spr_bombpepintro or obj_player.sprite_index == obj_player.spr_bombpeprunabouttoexplode or obj_player.sprite_index == obj_player.spr_bombpeprun or obj_player.sprite_index == obj_player.spr_fireass
				hudface = spr_pissinoHUD_panic // REPLACE
			else if _state = states.Sjumpland or (_state == states.freefallland && shake_mag > 0)  
				hudface = spr_pissinoHUD_stun
			else if obj_player.sprite_index = obj_player.spr_victory or _state = states.keyget or _state = states.smirk or _state = states.gottreasure or (_state = states.bossintro && obj_player.sprite_index = spr_player_levelcomplete)
				hudface = spr_pissinoHUD_happy
			else if obj_player.sprite_index == obj_player.spr_machroll or obj_player.sprite_index == obj_player.spr_tumble
				hudface = spr_pissinoHUD_rolling
			else if global.combo >= 3
				hudface = spr_pissinoHUD_menacing
			else if _state == states.mach1 or _state == states.tackle or _state == states.slam or _state == states.grab or _state == states.punch or _state == states.backkick or _state == states.uppunch or _state == states.shoulder
				hudface = spr_pissinoHUD_mach1
			else if _state == states.mach2 or obj_player.sprite_index == obj_player.spr_dive or _state == states.machroll or obj_player.sprite_index == obj_player.spr_machslideboost or _state = states.climbwall or _state = states.handstandjump or _state = states.superslam or _state == states.freefallprep
				hudface = spr_pissinoHUD_mach2
			else if _state == states.mach3 && obj_player.sprite_index == obj_player.spr_crazyrun
				hudface = spr_pissinoHUD_mach4
			else if _state == states.mach3 or obj_player.sprite_index == obj_player.spr_mach3boost
				hudface = spr_pissinoHUD_mach3
			else if _state == states.hurt or obj_player.sprite_index == obj_player.spr_fireassend or _state = states.timesup or _state = states.bombpep or (_state = states.bossintro &&  obj_player.sprite_index = obj_player.spr_bossintro) or (_state = states.bossintro &&  obj_player.sprite_index = obj_player.spr_idle)
				hudface = spr_pissinoHUD_hurt
			else if obj_player.sprite_index == obj_player.spr_bombpepend
				hudface = spr_pissinoHUD_bombend
			else if obj_player.sprite_index == obj_player.spr_bombpepend
				hudface = spr_pissinoHUD_bombend
			else if obj_player.angry
				hudface = spr_pepinoHUD3hp // REPLACE
			else if obj_player.sprite_index == obj_player.spr_hurtidle or obj_player.sprite_index == obj_player.spr_hurtwalk
				hudface = spr_pissinoHUD_1hp
			else if global.panic or global.snickchallenge or global.miniboss
				hudface = spr_pissinoHUD_panic
			else if obj_player.sprite_index == obj_player.spr_shotgunpullout
				hudface = spr_pissinoHUD_menacing
			else
				hudface = spr_pissinoHUD;
		}
		
		if obj_player.character == "PUFFER"
			hudface = spr_pufferHUD;
		
		if _state == states.cotton // temp
			hudface = spr_pizzyHUDcotton
		
		if sprite_exists(hudface)
		{
			if _state != states.cotton
				pal_swap_set(obj_player.spr_palette, obj_player.paletteselect, false)
			draw_sprite_ext(hudface, hudframe, 125, 100, 1, 1, 0, c_white, other.alpha)
			pal_swap_reset();
			
			// image speed
			var sprspd = sprite_get_speed(hudface);
			if sprspd != 1
				hudframe += sprspd;
			else
				hudframe += 0.35;
			if hudframe >= sprite_get_number(hudface)
				hudframe -= sprite_get_number(hudface);
		}
		
		// speed meter
		if !(obj_player.character == "N" && obj_player.noisetype == 0)
		{
			var yy = 140;
			if obj_player.character == "SP"
				yy = 164;
			
			var speedbaractive = _state == states.mach1 or _state == states.mach2 or _state == states.mach3 or _state == states.climbwall or _state == states.machslide or _state == states.machroll or _state == states.handstandjump;
			var frame = 0;
			
			if obj_player.movespeed < 2.4 or !speedbaractive
				frame = 0;
			else if speedbaractive
			{
				if obj_player.movespeed >= 2.4 && obj_player.movespeed < 4.8
					frame = 1;
				else if obj_player.movespeed >= 4.8 && obj_player.movespeed < 7.2
					frame = 2;
				else if obj_player.movespeed >= 7.2 && obj_player.movespeed < 9.6
					frame = 3;
				else if obj_player.movespeed >= 9.6 && obj_player.movespeed < 12
					frame = 4;
				else if obj_player.movespeed >= 12
				{
					frame = -1;
					draw_sprite_ext(scr_sprite_charsuffix(spr_speedbarmax), -1, 125, yy, 1, 1, 0, c_white, alpha);
				}
			}
			if frame >= 0
				draw_sprite_ext(scr_sprite_charsuffix(spr_speedbar), frame, 125, yy, 1, 1, 0, c_white, alpha);
		}
		
		// pogo noise bullshit
		with obj_player
		{
			if character == "N" && noisetype == 0
			{
				with other
				{
					if obj_player.pogospeed < 10
						draw_sprite_ext(spr_speedbar, 0, 125, 140, 1, 1, 0, c_white, alpha)
					else if obj_player.pogospeed >= 10 && obj_player.pogospeed < 14 
						draw_sprite_ext(spr_speedbar, 3, 125, 140, 1, 1, 0, c_white, alpha)
					else if obj_player.pogospeed >= 14
						draw_sprite_ext(spr_speedbarmax, -1, 125, 140, 1, 1, 0, c_white, alpha)
				}

			}
		}
		
		// fade
		if (obj_player.y < camera_get_view_y(view_camera[0]) + 200 && obj_player.x < camera_get_view_x(view_camera[0]) + 200)
		or (instance_exists(obj_gms) && ds_queue_size(global.__xmessage_queue) > 0 && global.__xms_waittime > 0)
			alpha = 0.5
		else
			alpha = 1
	}
	else
		shader_reset()
}

#endregion
#region new hud

else
{
	if (!instance_exists(obj_player) or obj_player.state != states.gameover) && showhud
	{
		if ((instance_exists(obj_player)
		&& obj_player.x < camera_get_view_x(view_camera[0]) + 250
		&& obj_player.y < camera_get_view_y(view_camera[0]) + 169)
		or manualhide) && !instance_exists(obj_fadeout)
			hud_posY = Approach(hud_posY, -300, 15);
		else
			hud_posY = Approach(hud_posY, 0, 15);
		
		// heat animation
		pizzascore_index += 0 + (0.25 * global.stylethreshold);
	    if pizzascore_index > pizzascore_number - 1
	        pizzascore_index = 0 + frac(pizzascore_index);
	    if global.stylethreshold <= 0
	    {
	        if floor(pizzascore_index) != 0
	            pizzascore_index += 0.35;
	        else
	            pizzascore_index = 0;
	    }
		
		// setup shit
		var b = global.style / 55;
		var hud_xx = 149 + irandom_range(-collect_shake, collect_shake);
	    var hud_yy = 105 + irandom_range(-collect_shake, collect_shake) + hud_posY;
		var repainted = instance_exists(obj_player) && obj_player.character == "PP";
		
		// heat meter
		var heatfill = spr_heatmeter_fill;
		var _heatspr = spr_heatmeter;
		var _heatpal = spr_heatmeter_palette;
		if sugary
		{
			_heatspr = spr_heatmeter_candy;
			_heatpal = spr_heatmeter_candy_palette;
			heatfill = spr_heatmeter_candyfill;
		}
		if repainted
			heatfill = spr_heatmeter_fillPP;
		
		var sw = sprite_get_width(heatfill);
	    var sh = sprite_get_height(heatfill);
		
		if !scr_stylecheck(2) && !repainted
		{
			if sprite_exists(_heatpal)
				pal_swap_set(_heatpal, global.stylethreshold, 0);
			draw_sprite_part(heatfill, pizzascore_index, 0, 0, sw * b, sh, hud_xx - 95, hud_yy + (sugary ? -87 : 24));
		    draw_sprite_ext(_heatspr, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
			pal_swap_reset();
		}
		
		// the big ass fucking pizza motherfucker
		var _pizzascore = spr_pizzascore;
		if sugary
			_pizzascore = spr_candyscore;
		if repainted
			_pizzascore = spr_pizzascorePP;
		
	    draw_sprite_ext(_pizzascore, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
		
		// draw the score
		var _crankpizza = repainted ? spr_pizzascore_pepperPP : spr_pizzascore_pepper;
		var _brankpizza = repainted ? spr_pizzascore_pepperoniPP : spr_pizzascore_pepperoni;
		var _arankpizza = repainted ? spr_pizzascore_olivePP : spr_pizzascore_olive;
		var _srankpizza = repainted ? spr_pizzascore_shroomPP : spr_pizzascore_shroom;
		
		if sugary or _pizzascore == spr_pizzascoreN
		{
			_crankpizza = -1;
			_brankpizza = -1;
			_arankpizza = -1;
			_srankpizza = -1;
		}
		
		var _score = global.collect;
		if _score >= global.crank && sprite_exists(_crankpizza)
		    draw_sprite_ext(_crankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
		if _score >= global.brank && sprite_exists(_brankpizza)
		    draw_sprite_ext(_brankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
		if _score >= global.arank && sprite_exists(_arankpizza)
		    draw_sprite_ext(_arankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
		if _score >= global.srank && sprite_exists(_srankpizza)
		    draw_sprite_ext(_srankpizza, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
		
		// draw in front of the pizza if repainted
		if !scr_stylecheck(2) && repainted
		{
			draw_sprite_part(spr_heatmeter_fillPP, pizzascore_index, 0, 0, sw * b, sh, hud_xx - 89, hud_yy - 87);
		    draw_sprite_ext(spr_heatmeterPP, pizzascore_index, hud_xx, hud_yy, 1, 1, 0, c_white, alpha);
		}
		
		// text
		draw_set_valign(fa_top)
	    draw_set_halign(fa_left)
		
		if sugary
			draw_set_font(global.candyfont)
		else if repainted
			draw_set_font(global.collectfontPP)
		else
			draw_set_font(global.collectfont)
		
		var text_y = 0;
	    switch floor(pizzascore_index - sugary)
	    {
	        case 1:
	        case 2:
	        case 3:
	            text_y = 1;
	            break;
	        case 5:
	        case 10:
	            text_y = -1;
	            break;
	        case 6:
	        case 9:
	            text_y = -2;
	            break;
	        case 7:
	            text_y = -3;
	            break;
	        case 8:
	            text_y = -5;
	            break;
	    }
		
	    var str = string(_score);
	    var num = string_length(str);
	    var w = string_width(str);
	    var xx = hud_xx - w / 2;
	    if lastcollect != _score
	    {
	        color_array = array_create(num, 0);
			for(var i = 0; i < array_length(color_array); i++)
				color_array[i] = choose(irandom(3));
	        lastcollect = _score;
	    }
		
	    draw_set_alpha(alpha);
	    for (i = 0; i < num; i++)
	    {
	        var yy = ((i + 1) % 2 == 0 ? -5 : 0);
	        var c = color_array[i];
			if !repainted
				pal_swap_set(spr_font_palette, c, 0);
	        draw_text(xx, hud_yy - 56 + text_y + yy, string_char_at(str, i + 1));
	        xx += w / num;
	    }
		
		draw_set_alpha(1);
	    pal_swap_reset();
		
		// bullet
		if instance_exists(obj_player) && global.gameplay == 1
		{
			var char = obj_player.character;
			if (char == "P" or char == "N")
			&& !scr_checkskin(checkskin.p_anton)
			{
			    var bx = hud_xx - 25;
			    var by = hud_yy + 20;
				if scr_stylecheck(2)
					by -= 32;
			    var bpad = 25;
			    var bspr = spr_peppinobullet_collectible;
			
			    if char == "N"
			    {
			        bx -= 6;
			        by += 57;
			        bspr = spr_playerN_noisebomb;
			    }
			
				var b = min(global.bullet, 960);
			
			    bx += bpad * b;
			    for (i = 0; i < b; i++)
			    {
			        bx -= bpad;
					if bx <= 960 + 32
						draw_sprite_ext(bspr, -1, bx, by, 1, 1, 0, c_white, alpha);
			    }
			}
		}
	}
}

#endregion

//Draw Text
draw_set_font(check_sugary() ? global.sugarybigfont : global.bigfont)
draw_set_halign(fa_center);
draw_set_color(c_white)

//Timer
if global.panic or global.snickchallenge or global.miniboss or global.timedgate
{
	var _seconds = global.seconds;
	var _minutes = global.minutes;
	
	var _color = c_white;
	if _minutes == 0 && _seconds <= 30
		_color = c_red
	var _middletext = (_seconds < 10 ? ":0" : ":");
	
	var xx = random_range(1, -1) + 480;
	if global.modifier == mods.no_toppings && global.gameplay != 0
		xx -= 75;
	draw_text_color(xx, random_range(1, -1) + (global.gameplay == 0 ? 65 : min(obj_tv.yi - 70, 540 - 60)), string(_minutes) + _middletext + string(_seconds), _color, _color, _color, _color, image_alpha);
}

if instance_exists(obj_player) && obj_player.character == "V" && showhud
{
	draw_set_colour(c_white);
	draw_text(200 + healthshake, 100 + healthshake + (global.gameplay == 0 ? 0 : 25), global.playerhealth)
}

//Key
if showhud
{
	var styley = 0;
	if scr_stylecheck(2) or (sugary && global.gameplay != 0)
		styley -= 32;
	
	if !sugary or global.gameplay == 0
	{
		var xx = 50;
		var yy = 30;
		if global.gameplay != 0
		{
			xx = 69;
			yy = 185 + hud_posY;
		}
		
		if global.key_inv
			draw_sprite_ext((check_sugary() ? spr_key_ss : spr_key), -1, xx, yy + styley, 1, 1, 0, c_white, alpha)
		draw_sprite_ext(spr_inv, -1, xx, yy + styley, 1, 1, 0, c_white, alpha)
	}
	if sugary && global.gameplay != 0
	{
		if global.key_inv
			draw_sprite_ext((check_sugary() ? spr_keyinvSP_ss : spr_keyinvSP), 0, 696, 86 + obj_tv.hud_posY + styley, 1, 1, 0, c_white, alpha);
		else
			draw_sprite_ext(spr_invSP, 0, 696, 86 + obj_tv.hud_posY + styley, 1, 1, 0, c_white, alpha);
	}
}

draw_set_blend_mode(bm_normal);