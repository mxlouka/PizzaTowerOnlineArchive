if ds_list_find_index(global.baddieroom, id) == -1 && global.gameplay == 0
	instance_create(x, y, obj_playerexplosion);
event_inherited();

