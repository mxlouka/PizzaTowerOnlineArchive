targetRoom = room
target_x = 0
target_y = 0

image_speed = 0
depth = 50
if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	depth += 100;

targetDoor = "A"

if global.gameplay == 0
{
	instance_change(obj_door, false);
	visited = true;
}