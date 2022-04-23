if obj_pause.pause
{
	instance_destroy();
	exit;
}
sync = check_bysync();

playerid = obj_player1
image_speed = 0
keep = false

randomize()
if !sync && scr_checkskin(checkskin.p_sage) or playerid.character == "S" or playerid.character == "PP"
	image_blend = choose(make_color_rgb(255, 0, 0), make_color_rgb(0, 255, 0));
else
	image_blend = choose(make_colour_rgb(96, 208, 72), make_colour_rgb(248, 0, 0));

if instance_exists(playerid)
{
	sprite_index = playerid.sprite_index;
	spr_palette = playerid.spr_palette;
	paletteselect = playerid.paletteselect;
}
else
{
	spr_palette = spr_peppalette;
	paletteselect = 0;
}

alarm[1] = 3
alarm[0] = 15

if !sync
	alarm[10] = 2;

drawx = camera_get_view_x(view_camera[view_current]);
drawy = camera_get_view_y(view_camera[view_current]);

