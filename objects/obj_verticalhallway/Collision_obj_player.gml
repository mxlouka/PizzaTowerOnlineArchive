with other
{
	y = min(y, other.y + (other.sprite_height - 46));
	
	if !instance_exists(obj_fadeout) or obj_fadeout.fadein && !instance_exists(obj_pausefadeout) && !obj_pause.pause
	{
		targetDoor = other.targetDoor
	    targetRoom = other.targetRoom
		
		verticalhallway = true
		vhallwaydirection = other.image_yscale
		
		var door = noone;
		switch targetDoor
		{
			case "A": door = obj_doorA; break;
			case "B": door = obj_doorB; break;
			case "C": door = obj_doorC; break;
			case "D": door = obj_doorD; break;
			case "E": door = obj_doorE; break;
		}
		if instance_exists(door)
			vhallwaypos = x - door.x
		else
			vhallwaypos = x - other.x
		
		if other.targetRoom == room
		{
			vhallwaydirection *= -1;
			vsp *= -1;
			
			if state == states.Sjump
				state = states.normal;
		}
		
		other.visited = true
		
		scr_soundeffect(sfx_door)
		instance_create(x, y, obj_fadeout)
	}
	if instance_exists(obj_pausefadeout)
	{
		x = xprevious;
		y = yprevious;
	}
}

