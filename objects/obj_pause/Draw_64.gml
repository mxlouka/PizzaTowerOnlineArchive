if pause or pausefad == 2
{
	if pausefad != 2
		application_surface_draw_enable(true);
	
	// manage fading
	if pausefad == 1 && pausealpha < 1
		pausealpha += 0.1;
	if pausefad == 2
	{
		if pausealpha > 0
			pausealpha -= 0.15;
		else
		{
			pausefad = 0;
			if sprite_exists(pausebg)
				sprite_delete(pausebg);
			exit;
		}
	}
	
	// draw the background
	if pausefad != 2
	{
		draw_set_colour(c_black);
		draw_rectangle(0, 0, 960, 540, false);
		draw_sprite_ext(spr_pausescreen, selected, 0, 4, 1, 1, 0, c_black, 1);
		draw_sprite_ext(spr_pausescreen, selected, 0, 0, 1, 1, 0, c_white, 1);
	}
	
	// fade
	draw_set_colour(c_black);
	draw_set_alpha(1 - clamp(pausealpha, 0, 1));
	if pausefad == 2
		draw_set_alpha(pausealpha);
	draw_rectangle(0, 0, 960, 540, false);
	draw_set_alpha(1);
}
else
{
	if surface_exists(pausesurf)
		surface_free(pausesurf);
}
