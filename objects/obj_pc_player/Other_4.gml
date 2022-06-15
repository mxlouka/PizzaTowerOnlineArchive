var doortarget = noone;
with obj_doorPARENT
	if door == other.targetDoor doortarget = id;
if instance_exists(doortarget)
{
	x = doortarget.x;
	y = doortarget.y;
}

canmove = true;
visible = true;

depth = -6;

if state == pc_states.dead
	state = pc_states.normal;

for(var i = 0; i < 64; i++)
{
	if scr_solid_player(x, y + i + 1)
	{
		y += i;
		break;
	}
}

