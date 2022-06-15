with obj_player
{
	if sign(other.image_yscale) == 1
	{
		if ((key_down && ((state == states.crouch or (character == "S" && scr_transformationcheck())) or state == states.machroll))
		or (state == states.crouchslide or state == states.freefall or state == states.freefallland))
		&& !instance_exists(obj_fadeout) && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other) && state != states.gameover && state != states.hitlag
			other.downbox(id, other);
	}
	if sign(other.image_yscale) == -1
	{
		if ((key_up && (state == states.normal or state == states.pogo or state == states.jump or state == states.mach1 or state == states.mach2 or state == states.mach3 or state == states.Sjumpprep or (state == states.punch && sprite_index == spr_breakdanceuppercut))) or ((state == states.Sjump or state == states.Sjumpland))) 
		&& !instance_exists(obj_fadeout) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 10, other) && state != states.gameover && state != states.hitlag
			other.upbox(id, other);
	}
}
