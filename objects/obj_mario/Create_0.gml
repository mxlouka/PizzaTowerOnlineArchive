if room != rm_mario
{
	room_goto(rm_mario);
	exit;
}

audio_stop_all();
scr_sound(mu_darkscreen);
with all
	if id != other.id instance_destroy(id, false);
image_alpha = 0;
