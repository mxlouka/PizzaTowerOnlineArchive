trigger = function() {
	return instance_exists(obj_fadeout) && !instance_exists(obj_destructiblerockblock) && !instance_exists(obj_tntblock);
}
func = function() {
	instance_destroy(obj_rockblock);
}

