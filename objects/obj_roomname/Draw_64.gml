// Draw Text
if !(instance_exists(obj_player) && obj_player.state == states.rotate)
{
	var sg = check_sugary();
	
	draw_set_alpha(1);
	draw_set_font(sg ? global.sugarysmallfont : global.smallfont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	
	draw_sprite(sg ? spr_roomnamebg_ss : spr_roomnamebg, 0, xi, yi);
	draw_text_auto(xi, yi + 8, message, 12, 280);
	
	// reset
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
