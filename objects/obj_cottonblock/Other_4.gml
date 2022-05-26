if ds_list_find_index(global.saveroom, id) != -1
	instance_destroy(id, false);
with obj_player
	if character == "V" instance_destroy(other, false);
