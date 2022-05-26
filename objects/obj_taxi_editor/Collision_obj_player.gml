if index < 0 exit;
if other.state != states.taxi && sprite_index == spr_taxiidle
{
	with obj_stopsign_editor
	{
		if index == other.index
		{
			other.sign_id = id;
			other.xx = x;
			other.yy = y;
		}
	}
	
	with other
	{
		visible = false;
		sprite_index = spr_idle;
		hsp = 0;
		vsp = 0;
		state = states.taxi;
		cutscene = true;
	}
	scr_soundeffect(sfx_taxi2)
	playerid = other
	sprite_index = spr_taximove	
	hsp = 10
}

