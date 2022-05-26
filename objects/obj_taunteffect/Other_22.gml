sugary = variable_map[?"sugary"];
if instance_exists(obj_pause) && obj_pause.pause
	instance_destroy();
else if point_in_camera(x, y, view_camera[0])
{
	if sugary
		scr_soundeffect(sfx_tauntSP_1, sfx_tauntSP_2, sfx_tauntSP_3, sfx_tauntSP_4, sfx_tauntSP_5, sfx_tauntSP_6, sfx_tauntSP_7, sfx_tauntSP_8);
	else
		scr_soundeffect(sfx_taunt);
}

