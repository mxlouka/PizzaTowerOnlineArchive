// culling
if scr_culling()
	exit;

// Draw
haspalette = (object_index == obj_cheeseslime or object_index == obj_forknight or object_index == obj_pepgoblin or object_index == obj_pizzard or object_index == obj_thug_blue or object_index == obj_thug_green or object_index == obj_sausageman or object_index == obj_minijohn or object_index == obj_swedishmonkey or object_index == obj_robot or object_index == obj_indiancheese);
if haspalette && !flash
	pal_swap_set(spr_palette, (scr_stylecheck(2) && global.stylethreshold >= 3 ? 2 : paletteselect), false)

draw_set_flash(flash);
draw_sprite_ext(sprite_index, image_index, x, y + (1 - yscale) * (50 - 4), image_xscale, image_yscale * yscale, img_angle, image_blend, image_alpha);
draw_set_flash(false);

if haspalette
	pal_swap_reset()

