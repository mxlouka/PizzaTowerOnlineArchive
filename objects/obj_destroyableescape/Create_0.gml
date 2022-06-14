global.breaksound = 0
depth = 1

if check_sugary()
{
	sprite_index = spr_destroyableescape_ss
	if global.gameplay != 0
		sprite_index = spr_destroyableescapeNEW_ss
}
else if global.gameplay != 0
	instance_destroy(id, false)

momentum = [0, 0];
