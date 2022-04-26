if sprite_index == spr_ufogrounded_bullet && scr_stylecheck(2)
{
	with instance_create(x, y, obj_cloudeffect)
		sprite_index = spr_ufogrounded_bulletdestroy;
}

