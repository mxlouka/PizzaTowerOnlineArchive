if obj_player1.character == "N"
	sprite_index = spr_halloweensmallblockescape
else if obj_player1.character == "SP"
	sprite_index = spr_destroyable2escape_ss
else if obj_player1.character == "PP"
	sprite_index = spr_destroyable21_PP
else if global.gameplay != 0
	sprite_index = spr_destroyable2escape_NEW

depth = 1
image_speed = 0.35;
image_index = random(image_number);

momentum = [0, 0];