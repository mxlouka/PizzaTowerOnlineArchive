if place_meeting(x, y, obj_parryhitbox)
	exit;

with other
{
	if character == "V"
		scr_hurtplayer(id)
	else if state != states.boots && state != states.gameover && state != states.rideweenie && state != states.hitlag
	{
		scr_transfobump(false);
		
		gp_vibration(1, 1, 0.85)
		state = states.fireass
		vsp = -25
		sprite_index = spr_fireass
		image_index = 0
		
		if !audio_is_playing(snd_fireass) or audio_sound_get_track_position(other.firesnd) >= 0.5
		{
			audio_stop_sound(snd_fireass);
			other.firesnd = scr_soundeffect(snd_fireass);
		}
	}
}

