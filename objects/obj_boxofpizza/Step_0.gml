with obj_player
{
	if sign(other.image_yscale) == 1
	{
		if ((key_down && !place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other)
		&& ((state == states.crouch or (character == "S" && scr_transformationcheck())) or state == states.machroll))
		or ((state == states.crouchslide or state == states.freefall or state == states.freefallland)))
		&& !instance_exists(obj_fadeout)
		{
			other.depth = -10
			scr_soundeffect(sfx_box)
			box = true
			mach2 = 0
			obj_camera.chargecamera = 0
			
			doorx = other.x
			if !scr_stylecheck(2)
				x = doorx;
			
			targetDoor = other.targetDoor
			targetRoom = other.targetRoom
			
			sprite_index = spr_downpizzabox
			image_index = 0
			state = states.door
			
			vsp = 0
		}
	}
	
	if sign(other.image_yscale) == -1
	{
		if ((key_up && !place_meeting(x, y - 1,obj_destructibles) && place_meeting(x, y - 10, other)
		&& (state == states.normal or state == states.pogo or state == states.jump or state == states.mach1 or state == states.mach2 or state == states.mach3 or state == states.Sjumpprep or (state == states.punch && sprite_index == spr_breakdanceuppercut))) or ((state == states.Sjump or state == states.Sjumpland))) 
		&& !instance_exists(obj_fadeout)
		{
			other.depth = -8
			scr_soundeffect(sfx_box)
			box = true
			mach2 = 0
			obj_camera.chargecamera = 0
			
			doorx = other.x
			x = doorx;
			
			y = other.y + 24
			targetDoor = other.targetDoor
			targetRoom = other.targetRoom
			
			sprite_index = spr_uppizzabox
			image_index = 0
			state = states.door
			
			vsp = 0
		}
	}
}

if place_meeting(x, y - image_yscale * 6, obj_doorA)
	targetDoor = "A"
if place_meeting(x, y - image_yscale * 6, obj_doorB)
	targetDoor = "B"
if place_meeting(x, y - image_yscale * 6, obj_doorC)
	targetDoor = "C"
if place_meeting(x, y - image_yscale * 6, obj_doorD)
	targetDoor = "D"
if place_meeting(x, y - image_yscale * 6, obj_doorE)
	targetDoor = "E"
if place_meeting(x, y - image_yscale * 6, obj_doorANY)
	targetDoor = instance_place(x, y - image_yscale, obj_doorANY).door

