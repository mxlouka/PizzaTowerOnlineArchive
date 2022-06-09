if instance_exists(player) && scr_stylecheck(2)
	pal_swap_set(player.spr_palette, player.paletteselect, false);
draw_self();
pal_swap_reset();
