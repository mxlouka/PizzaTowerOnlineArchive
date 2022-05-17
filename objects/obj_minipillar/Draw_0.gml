if !(sprite_index == spr_minipillarsleep && global.snickchallenge)
{
	if image_xscale == 1 && image_yscale == 1
		draw_sprite_ext(sprite_index, image_index, xstart, ystart, 1, 1, image_angle, image_blend, image_alpha)
	else
	{
		for (var i = 0; i < abs(image_xscale); i++)
		{
			for (var j = 0; j < abs(image_yscale); j++)
				draw_sprite_ext(sprite_index, -1, xstart + (32 * i), ystart + (32 * j), 1, 1, image_angle, image_blend, image_alpha)
		}
	}
}

