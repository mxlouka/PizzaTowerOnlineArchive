if live_call() return live_result;

// flashing and apply palette
drawspr = sprite_index;
if flash
	draw_set_flash(true);
else
	pal_swap_set(spr_palette, paletteselect, false);

// draw
draw_sprite_ext(drawspr, image_index, x, y, xscale, yscale, img_angle, shadowcolor, image_alpha * 0.85);
pal_swap_reset();

// reset flash and palette
draw_set_flash(false);

