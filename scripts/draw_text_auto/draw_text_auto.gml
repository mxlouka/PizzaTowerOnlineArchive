function draw_text_auto(x, y, str, sep = undefined, w = undefined, alpha = draw_get_alpha())
{
	str = string(str);
	
	if draw_get_font() == global.bigfont or draw_get_font() == global.sugarybigfont
	or draw_get_font() == global.smallfont or draw_get_font() == global.sugarysmallfont
		str = string_upper(str);
	
	var aprev = draw_get_alpha();
	draw_set_alpha(alpha);
	
	if is_undefined(sep) && is_undefined(w)
		draw_text(x, y, str);
	else
		draw_text_ext(x, y, str, sep, w);
	
	draw_set_alpha(aprev);
}

