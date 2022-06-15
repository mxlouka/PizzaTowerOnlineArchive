title_index = 0
title = 0
vsp = 0
alpha = 3
depth = -10
alarm[0] = 3
image_speed = 0

sugary = false;
with obj_player
{
	if character == "SP"
		other.sugary = true;
}

if sugary
{
	image_speed = 0.35;
	var timesource = time_source_create(time_source_game, 1, time_source_units_frames, function()
	{
		sprite_index = spr_comboend_titleSP;
		if title >= 6
			sprite_index = spr_wtfcombo_boil;
	});
	time_source_start(timesource);
}
