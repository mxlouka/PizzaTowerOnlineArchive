audio_stop_all();
alarm[0] = room_speed;
with all
{
	if id != other.id && object_index != obj_gms && object_index != obj_otherplayer && object_index != obj_controller
	&& object_index != obj_wc && object_index != obj_gmlive && object_index != obj_drpc_updater
		instance_deactivate_object(id);
}

with obj_gms
	gms_settings(true, gameversion, obj_pc_player, obj_otherplayer);

