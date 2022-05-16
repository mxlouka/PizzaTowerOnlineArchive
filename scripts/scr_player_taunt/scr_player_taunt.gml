function scr_player_taunt()
{
	with (inst_relation(id, obj_player) ? id : obj_player)
	{
		if (!instance_exists(obj_fadeout) or obj_fadeout.fadein)
		&& state != states.backbreaker
		{
			grav = basegrav;
			
			taunttimer = 20
			tauntstoredmovespeed = movespeed
			tauntstoredsprite = sprite_index
			tauntstoredstate = state
			state = states.backbreaker
			
			if supercharged && !audio_is_playing(sfx_supertaunt) && !audio_is_playing(sfx_supertaunt_SP) && scr_stylecheck(2)
			{
				if character == "SP"
					scr_soundeffect(sfx_supertaunt_SP)
				else
					scr_soundeffect(sfx_supertaunt)
			}
			else
			{
				if character == "SP"
					scr_soundeffect(sfx_tauntSP_1, sfx_tauntSP_2, sfx_tauntSP_3, sfx_tauntSP_4, sfx_tauntSP_5, sfx_tauntSP_6, sfx_tauntSP_7, sfx_tauntSP_8);
				else
					scr_soundeffect(sfx_taunt)
			}
			
			if supercharged && character != "S" && character != "V" && character != "PP"
			{
				image_index = 0
				sprite_index = choose(spr_supertaunt1, spr_supertaunt2, spr_supertaunt3, spr_supertaunt4)
			}
			else
			{
				taunttimer = 20
				sprite_index = spr_taunt
				image_index = irandom(sprite_get_number(sprite_index))
				image_speed = 0
				
				// new gameplay removed beter :(
				if sprite_index == spr_player_taunt
				{
					if image_index == 10 && global.gameplay == 1
						image_index = 9;
					if image_index == 11 && global.gameplay != 2
						image_index = 9;
				}
			}
			with instance_create(x, y, obj_taunteffect)
			{
				player = other.id;
				depth = other.depth + 1;
			}
		}
	}
}