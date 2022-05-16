function scr_playersounds()
{
	//Sounds
	with obj_player
	{
		if state == states.hitlag
			exit;
		
		// set mach sounds
		var _sfx_mach1 = global.machsound == 0 ? sfx_mach1 : sfx_mach1_old;
		var _sfx_mach2 = global.machsound == 0 ? sfx_mach2 : sfx_mach2_old;
		var _sfx_mach3 = global.machsound == 0 ? sfx_mach3 : sfx_mach3_old;
		var _sfx_mach4 = global.machsound == 0 ? sfx_mach4 : sfx_mach3_old;
		var _sfx_tumble3 = (global.machsound == 1 && sprite_index == spr_machroll) ? sfx_machroll : sfx_tumble3;
		
		// mach1 sound
		if (state == states.mach1 or sprite_index == spr_cotton_run) && grounded
		{
			if !audio_is_playing(mach1snd)
				mach1snd = scr_soundeffect(_sfx_mach1);
		}
		else
			audio_stop_sound(mach1snd);
		
		// mach2 sound
		if (sprite_index == spr_mach or sprite_index == spr_player_machhit or state == states.climbwall or (sprite_index == spr_cotton_maxrun && grounded)
		or (sprite_index == spr_rollgetup && image_index >= 8))
		&& state != states.backbreaker
		{
			if !audio_is_playing(mach2snd)
				mach2snd = scr_soundeffect_ext(_sfx_mach2, true);
		}
		else
			audio_stop_sound(mach2snd);
		
		// mach3 sound
		if (state == states.mach3 or sprite_index == spr_mach3boost) && sprite_index != spr_crazyrun
		&& state != states.backbreaker
		{
			if !audio_is_playing(mach3snd)
				mach3snd = scr_soundeffect_ext(_sfx_mach3, true);
		}
		else
			audio_stop_sound(mach3snd);
		
		// knightpep slope
		if state == states.knightpepslopes
		{
			if !audio_is_playing(knightslide)
				knightslide = scr_soundeffect_ext(sfx_knightslide, true);
		}
		else
			audio_stop_sound(knightslide)
		
		// bombpep
		if (sprite_index == spr_bombpeprun or sprite_index == spr_bombpeprunabouttoexplode)
		&& state != states.backbreaker
		{
			if !audio_is_playing(bombpep1snd)
				bombpep1snd = scr_soundeffect_ext(sfx_bombpep1, true)
		}
		else
			audio_stop_sound(bombpep1snd)
		
		// mach4
		if sprite_index == spr_crazyrun && state != states.backbreaker
		{
			if !audio_is_playing(mach4snd)
				mach4snd = scr_soundeffect_ext(_sfx_mach4, true)
		}
		else
			audio_stop_sound(mach4snd)
		
		// sjump prep
		if state != states.Sjumpprep && audio_is_playing(sfx_superjumpprep)
			audio_stop_sound(sfx_superjumpprep)
		
		// sjump hold
		if state != states.Sjumpprep && audio_is_playing(superjumpholdsnd)
			audio_stop_sound(superjumpholdsnd)
		
		// tumble starting
		if sprite_index == spr_tumblestart && !audio_is_playing(tumble1snd) && floor(image_index) < 11
			tumble1snd = scr_soundeffect(sfx_tumble1)
		
		// tumble start
		if sprite_index == spr_tumblestart && floor(image_index) >= 11 && !audio_is_playing(tumble2snd)
		{
			tumble2snd = scr_soundeffect(sfx_tumble2)
			audio_stop_sound(tumble1snd)
		}
		
		// tumbling
		if (sprite_index == spr_tumble or sprite_index == spr_machroll) && !audio_is_playing(tumble3snd) 
			tumble3snd = scr_soundeffect_ext(_sfx_tumble3, true)
		
		// stop tumbling sounds
		if state != states.tumble && (sprite_index != spr_machroll or state == states.backbreaker)
		{
			audio_stop_sound(tumble1snd)
			audio_stop_sound(tumble2snd)
			audio_stop_sound(tumble3snd)
		}
		
		// stop suplex dash sound
		if audio_is_playing(suplexdashsnd) && state != states.handstandjump && state != states.punch
			audio_stop_sound(suplexdashsnd)
		
		// bitch sound
		if sprite_index == spr_mach2jump && character == "SP" && global.gameplay != 0
		{
			if !audio_is_playing(flipsnd)
				flipsnd = scr_soundeffect(sfx_flip_ss)
		}
		else
			audio_stop_sound(flipsnd)
	}
}

