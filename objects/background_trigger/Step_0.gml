if place_meeting(x, y, obj_player)
{
	if !docol && cam == noone or other.cam == cam
	{
		scr_set_background_trigger(index)
		scr_set_bgspd_trigger()
	}
	docol = true;
}
else
	docol = false;

