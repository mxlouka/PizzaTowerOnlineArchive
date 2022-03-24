/// @description gmlive by yellowafterlife
#macro live_enabled debug
if !live_enabled
{
	instance_destroy();
	exit;
}

// this is a simple safeguard against making multiple obj_gmlive instances
while instance_number(obj_gmlive) > 1
{
	var find = instance_find(obj_gmlive, 0);
	if id != find.id
		instance_destroy();
}

// change the IP/port here if gmlive-server isn't running on the same device as the game
// (e.g. when running on mobile platforms):
live_init(1, "http://localhost:5100", "");
