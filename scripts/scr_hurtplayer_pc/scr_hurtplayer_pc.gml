function scr_hurtplayer_pc(collectloss = 100, player = obj_pc_player)
{
	if player.canmove && player.state != pc_states.pipe
	{
		if !audio_is_playing(sfx_pephurt)
			audio_play_sound(sfx_pephurt, 0, false);

		player.hsp = -player.xscale * 50;
		player.vsp = -10;
		player.sprite_index = player.spr_hurt;
		global.collect = max(global.collect - collectloss, 0);
	}
}

