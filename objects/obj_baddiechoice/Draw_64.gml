event_inherited();

// draw the skins
var _spr = spr_idle;

img += sprite_get_speed(_spr) * 0.35;
if img >= sprite_get_number(_spr)
	img -= sprite_get_number(_spr);

draw_set_colour(c_white);
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

if sprite_exists(_spr)
	draw_sprite_ext(_spr, img, (960 / 2) + xoffset, (540 / 2) + yoffset, 2, 2, 0, c_white, ((100 - abs(xoffset) - abs(yoffset)) / 100) * talpha);

// text
palname = ((sel[0] < array_length(selarray) && array_length(selarray[sel[0]]) >= 2) ? selarray[sel[0]][1] : "Unknown");
paldesc = ((sel[0] < array_length(selarray) && array_length(selarray[sel[0]]) >= 3) ? selarray[sel[0]][2] : "loypoll please add details");
