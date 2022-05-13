pal_swap_init_system(shd_pal_swapper);

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
{
	x = door.x;
	y = door.y;
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

