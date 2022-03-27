image_speed = 0.35

if instance_exists(obj_player1)
{
	if obj_player1.character == "N"
		sprite_index = spr_giantpizzahalloween
	if obj_player.character == "S"
		sprite_index = spr_snickcollectible3
	if obj_player.character == "SP"
		sprite_index = spr_giantpizza_ss
	if obj_player.character == "PP"
		sprite_index = spr_giantpizza_PP
}

if global.snickrematch
	sprite_index = spr_giantpizza_re

depth = 4
if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	depth += 100;
