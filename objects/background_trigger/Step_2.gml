var player = instance_place(x, y, obj_player);
if player
{
	if !docol && (cam == noone or player.cam == cam)
	{
		scr_set_background_trigger(index)
		scr_set_bgspd_trigger()
	}
	docol = true;
}
else
	docol = false;

