image_speed = 0.5
depth = 1

if !check_online()
	exit;

if check_bysync() == false
	gms_instance_sync(id, is_onetime | isc_local);
else if point_in_camera(x, y, view_camera[0])
&& obj_pause.pause == false
	scr_soundeffect(sfx_taunt);

if obj_pause.pause
	instance_destroy();

