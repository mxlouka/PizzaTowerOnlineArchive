if !instance_exists(obj_pause)
{
	instance_destroy();
	exit;
}

if fadealpha >= 1 && !fadein
{
	if obj_pause.pause
	{
		// unpause
		audio_resume_all();
		
		obj_pause.pause = false;
		obj_pause.pausefad = 2;
		obj_pause.pausealpha = 1;
		
		while true
		{
			_act = array_pop(obj_pause.objectlist);
			if _act == undefined
				break;
			instance_activate_object(_act);
		}
		
		alarm[0] = 1;
	}
	else
	{
		// pause
		audio_pause_all()
		
		with obj_pause
		{
			pause = true;
			pausefad = 1;
			pausealpha = 0;
			pausebg = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0);
			
			with obj_player
			{
				other.character = character;
				other.paletteselect = paletteselect;
			}
		}
		
		with all
		{
			if object_index != obj_pause && object_index != obj_otherplayer && object_index != obj_gms
			&& object_index != obj_wc && object_index != obj_onlinemenu && object_index != obj_gmlive
			&& object_index != obj_inputdisplay && id != other.id
			{
				array_push(obj_pause.objectlist, id);
				instance_deactivate_object(id);
			}
			if object_index == obj_fadeout
				instance_destroy();
		}
		
		global.__chat = false;
	}

	fadein = true
}

if !fadein
	fadealpha += 0.1
else
{
	fadealpha -= 0.1
	//if fadealpha <= 0
		instance_destroy();
}
