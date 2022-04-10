if !other.rebound
	exit;
if global.gameplay != 2
	exit;

// no need to have duplicate code
event_perform(ev_collision, obj_shotgunbullet);

