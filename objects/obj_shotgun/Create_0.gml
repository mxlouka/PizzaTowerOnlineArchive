image_speed = 0.35
hsp = 0
vsp = 0
grav = 0.5
grounded = false

depth = 10
if place_meeting(x, y, obj_destructibles) or place_meeting(x, y, obj_metalblock)
	depth += 100;

pickupimg = 0

with obj_player1
	if character == "S" instance_destroy(other.id);
