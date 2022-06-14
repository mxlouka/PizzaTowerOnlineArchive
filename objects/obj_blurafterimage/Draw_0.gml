if instance_exists(playerid)
	pal_swap_set(playerid.spr_palette, playerid.paletteselect, false);
draw_self();
pal_swap_reset();
