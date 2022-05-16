event_inherited()
depth = 1

if global.gameplay == 1
	sprite_index = spr_bigdestroyableescape_NEW
if check_sugary()
{
	sprite_index = spr_bigdestroyableescape_ss
	if global.gameplay != 0
		sprite_index = spr_bigdestroyableescapeNEW_ss
}

momentum = [0, 0];

