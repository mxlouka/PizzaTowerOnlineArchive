/// @description new debris
if sprite_index == spr_metalblockdebris_NEW or sprite_index == spr_metalblockdebrisescape_NEW
	image_index += 0.35;

x += momentum[0];
y += momentum[1];
momentum[0] = lerp(momentum[0], 0, 0.35);
momentum[1] = lerp(momentum[1], 0, 0.35);

