image_speed = 0.35

if !check_online()
	exit;

if check_bysync() == false
	gms_instance_sync(id, is_onetime | isc_local);
