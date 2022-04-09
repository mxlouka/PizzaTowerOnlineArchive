if (obj_player.state == states.normal or obj_player.state == states.mach1 or obj_player.state == states.pogo or obj_player.state == states.mach2 or obj_player.state == states.mach3 or obj_player.state == states.Sjumpprep) && (sprite_index == spr_doorkey or sprite_index == spr_keydoor_ss) && obj_player.key_up && obj_player.grounded && global.key_inv == true && place_meeting(x, y, obj_player) 
{
	ds_list_add(global.saveroom, id)
	
	obj_player.state = states.victory
	obj_player.image_index = 0
	obj_player.keydoor = true
	obj_player.doorx = x + 50;
	
	with instance_create(x + 50, y + 50, obj_lock)
		if other.sprite_index == spr_keydoor_ss
			sprite_index = spr_lock_ss
	
	image_index = 0
	if sprite_index == spr_keydoor_ss
		sprite_index = spr_door_ss
	else
		sprite_index = spr_doorkeyopen
	
	image_speed = 0.35
	
	global.key_inv = false
}

if sprite_index == spr_doorkeyopen && floor(image_index) >= 2
	sprite_index = spr_doorvisited

if floor(obj_player.image_index) >= obj_player.image_number - 1 && obj_player.state == states.victory && place_meeting(x, y, obj_player)
{
	with obj_player
	{
		targetDoor = other.targetDoor
		targetRoom = other.targetRoom
		
		if !instance_exists(obj_fadeout)
		{
			scr_soundeffect(sfx_door)
			instance_create(x, y, obj_fadeout)
		}
	}
}

if targetRoom != room
{
	if place_meeting(x, y, obj_doorA)
		targetDoor = "A"
	if place_meeting(x, y, obj_doorB)
		targetDoor = "B"
	if place_meeting(x, y, obj_doorC)
		targetDoor = "C"
	if place_meeting(x, y, obj_doorD)
		targetDoor = "D"
	if place_meeting(x, y, obj_doorE)
		targetDoor = "E"
	if place_meeting(x, y, obj_doorANY)
		targetDoor = instance_place(x, y, obj_doorANY).door
}

