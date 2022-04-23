/// @description sync
if !check_online()
	exit;

if !sync && instance_number(object_index) < 50
{
	gms_instance_sync_var_add("spr", sprite_index);
	gms_instance_sync_var_add("img", image_index);
	gms_instance_sync_var_add("xscale", image_xscale);
	gms_instance_sync_var_add("blend", image_blend);
	gms_instance_sync(id, is_onetime | isc_local);
}

