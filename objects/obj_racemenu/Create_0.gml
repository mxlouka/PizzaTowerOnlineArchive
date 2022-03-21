/// @description it doesn't actually work so lol
if !debug
{
	instance_destroy();
	exit;
}

instance_destroy(obj_fadeout);
audio_stop_all();
scr_sound(mu_medievalrace);
instance_deactivate_all(true);
instance_activate_object(obj_gms);

menu = 0;
maxplayer = 2;
startrace = false;
password = "";

function gms_session_change(session_id) {
	with obj_racemenu
		if floor(menu) == 3
			menu = frac(menu) * 10;
}
gms_script_set_session_change(gms_session_change);