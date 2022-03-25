var _spr = sprite_index;
if instance_exists(playerid) && playerid.character == "PP"
{
	if _spr == sprite1039
		_spr = spr_shotgunbulletPP;
	if _spr == sprite10391
		_spr = spr_shotgunbullet2PP;
}

draw_sprite_ext(_spr, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
