var telep = false;
if instance_number(obj_pc_player) > 1
{
	with obj_pc_player
	{
		if state != pc_states.dead && state != pc_states.CAUGHTYOU
		{
			other.x = x;
			other.y = y;
			telep = true;
		}
	}
}

if !telep
	room_restart();

state = pc_states.jump;
canmove = true;
visible = true;
scr_hurtplayer_pc();
hsp = 0;
vsp = 0;
audio_stop_sound(sfx_pephurt);
xscale = 1;

mask_index = spr_player_mask;

