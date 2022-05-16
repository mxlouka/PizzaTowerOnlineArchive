// draw
if sprite_index == spr_yousuck
	pal_swap_set(spr_peppalette, clamp(playerobj.paletteselect, 1, pal_swap_get_pal_count(spr_peppalette) - 1), false)
else
	pal_swap_set(playerobj.spr_palette, playerobj.paletteselect, false)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
shader_reset()

// the text
if global.modifier != -1
{
	if image_index >= image_number - 1
		draw_sprite_ext(spr_rank_passed, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}
else
{
	if asset_get_type(sprite_get_name(sprite_index) + "_text") == asset_sprite
		draw_sprite_ext(asset_get_index(sprite_get_name(sprite_index) + "_text"), image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

