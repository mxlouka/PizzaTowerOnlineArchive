if live_call() return live_result;
event_inherited();

// song names
var _palname = selarray[sel[1]][1];
var _paldesc = selarray[sel[1]][2];

draw_set_alpha(talpha);

draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_font(titlefont);
draw_text_auto((960 / 1.5) + random_range(-1, 1), 540 - 250 + yoffset, _palname,,,talpha);

draw_set_valign(fa_top);
draw_set_font(descfont);
draw_text_auto(960 / 1.5, 540 - 234 + yoffset, _paldesc, 16, 960 - 32, talpha);

// game names
for(var i = 0; i < array_length(gamearray); i++)
{
	draw_set_colour(sel[0] == i ? c_white : c_gray);
	draw_text(lerp(150, 960 - 150, i / (array_length(gamearray) - 1)), 32, gamearray[i]);
}

// song list
draw_set_halign(fa_left);

var scroller = max((sel[1] - 8) * 16, 0);
for(var i = 0; i < array_length(selarray); i++)
{
	var yy = 128 + i * 16;
	yy -= scroller;
	
	if yy < 0
		continue;
	if yy > 540
		break;
	
	if yy <= 128
		draw_set_alpha((yy / 128) * talpha);
	if yy > 540 - 128
		draw_set_alpha(((540 - yy) / 128) * talpha);
	
	draw_set_colour(sel[1] == i ? c_white : c_ltgray);
	draw_text(64, yy, string_replace_all(selarray[i][1], "\n", " "));
}

img += 0.35;
draw_set_alpha(talpha);
draw_sprite(spr_cursor, img, 64 - 36, 128 + 10 - scroller + sel[1] * 16);

// song position
var pos = 0;
if global.jukebox != -1 && audio_is_playing(selarray[sel[1]][0])
	pos = (audio_sound_get_track_position(global.jukebox) / audio_sound_length(global.jukebox)) * 480;

draw_set_colour(c_gray);
draw_rectangle(400, 350 + yoffset, 400 + 480, 350 + 15 + yoffset, false);
draw_set_colour(c_white);
draw_rectangle(400, 350 + yoffset, 400 + pos, 350 + 15 + yoffset, false);
draw_circle(400 + pos, 350 + 15 / 2 + yoffset, 15, false);
draw_set_colour(c_black);
draw_circle(400 + pos, 350 + 15 / 2 + yoffset, 15, true);

draw_set_alpha(1);

