draw_set_font(fnt_pizzacastle);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

for(var i = 0; i < array_length(levels); i++)
{
	var yy = 20;
	if i > 0
		yy += lerp(20, 540, i / array_length(levels))
	
	draw_set_colour(sel == i ? c_red : c_white);
	draw_text(540, yy, levels[i]);
}

draw_set_color(c_white);
var chardisplay = "unknown";
switch char
{
	case 0: chardisplay = "Pepino"; break;
	case 1: chardisplay = "the Sound"; break;
	case 2: chardisplay = "Vigilacio"; break;
	case 3: chardisplay = "Snic K"; break;
	case 4: chardisplay = "Pezelle"; break;
	case 5: chardisplay = "The Man"; break; // pissino
}
draw_text(4, 486, "Player: " + chardisplay);

