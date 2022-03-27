image_speed = 0.35
targetRoom = room
target_x = 0
target_y = 0

depth = 4;
if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	depth += 100;

targetDoor = "A"
if check_sugary()
	sprite_index = spr_keydoor_ss