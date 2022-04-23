scr_collide()

if obj_player.character == "N"
{
	if sprite_index != spr_minigun && grounded
		y -= 10;
	sprite_index = spr_minigun;
}
else if obj_player.character == "PP"
	sprite_index = spr_coconutgun;
else
	sprite_index = spr_shotgun;

