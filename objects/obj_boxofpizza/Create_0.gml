image_speed = 0.35;
if room != custom_lvl_room
	depth = 4;

targetRoom = room;
targetDoor = "A";

if obj_player.character == "N" && scr_stylecheck(2)
	sprite_index = spr_boxofpizzaN
if check_sugary()
{
	sprite_index = spr_boxofpizzaSP
	mask_index = sprite_index
}

if string_startswith(room_get_name(room), "strongcold")
	sprite_index = spr_xmaspizzaboxdown
if global.snickrematch
	sprite_index = spr_boxofpizza_re

downbox = function(pbox)
{
	pbox.depth = -8
	scr_soundeffect(sfx_box)
	box = true
	mach2 = 0
	obj_camera.chargecamera = 0
			
	doorx = pbox.x
	if !scr_stylecheck(2)
		x = doorx;
			
	targetDoor = pbox.targetDoor
	targetRoom = pbox.targetRoom
			
	sprite_index = spr_downpizzabox
	image_index = 0
	state = states.door
			
	vsp = 0
}
upbox = function(pbox)
{
	pbox.depth = -8
	scr_soundeffect(sfx_box)
	box = true
	mach2 = 0
	obj_camera.chargecamera = 0
			
	doorx = pbox.x
	x = doorx;
			
	y = pbox.y + 24
	targetDoor = pbox.targetDoor
	targetRoom = pbox.targetRoom
			
	sprite_index = spr_uppizzabox
	image_index = 0
	state = states.door
			
	vsp = 0
}

