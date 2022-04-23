draw_set_alpha(fadealpha); // Increase or decrease to change tint intensity
draw_set_color(c_black); // Change to the color you want
draw_rectangle(_camx - 64, _camy - 64, _camx + _camw + 64, _camy + _camh + 64, false);
draw_set_alpha(1);

