hp = 2
if obj_player1.character == "N"
	sprite_index = spr_halloweenbigblockescape
else if obj_player1.character == "SP"
	sprite_index = spr_destroyable2bigescape_ss
else if obj_player1.character == "PP"
	sprite_index = spr_bigbreakableescape_PP
else if global.gameplay == 1
	sprite_index = spr_bigbreakableescape_NEW

depth = 1
content = noone
image_speed = 0.35;
image_index = random(image_number);

momentum = [0, 0];
