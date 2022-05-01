//Draw
if !obj_player1.spotlight
	pal_swap_set(obj_player1.spr_palette, obj_player1.paletteselect, false)
else
	pal_swap_set(obj_player2.spr_palette, obj_player2.paletteselect, false)
draw_sprite(sprite, -1, X, Y)
shader_reset()

