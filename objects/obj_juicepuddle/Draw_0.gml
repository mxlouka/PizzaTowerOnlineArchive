pal_swap_set(spr_juicepalette, palette, false);
draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, img_angle, image_blend, image_alpha);
pal_swap_reset();

