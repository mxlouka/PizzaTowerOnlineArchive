event_inherited()
depth = 1

if check_sugary()
{
	sprite_index = spr_bigdestroyableescape_ss
	if global.gameplay != 0
		sprite_index = spr_bigdestroyableescapeNEW_ss
}
else if global.gameplay != 0
	instance_destroy(id, false);

momentum = [0, 0];
