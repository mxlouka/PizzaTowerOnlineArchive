event_inherited()
if obj_player1.character == "N"
	sprite_index = spr_halloweenbigblockescape
else if obj_player1.character == "SP"
{
	sprite_index = spr_destroyable2bigescape_ss
	if global.gameplay != 0
		sprite_index = spr_destroyable2bigescapeNEW_ss
}
else if obj_player1.character == "PP"
	sprite_index = spr_bigbreakableescape_PP

depth = 1
content = noone
image_speed = 0.35;
image_index = random(image_number);

momentum = [0, 0];

