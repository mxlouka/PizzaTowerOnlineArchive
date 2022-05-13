enum pc_states
{
	normal,
	jump,
	mach4,
	dead,
	floatup,
	crouch,
	revolver,
	CAUGHTYOU,
	ice,
	superjumpprep,
	superjump,
	pipe
}

ds_list_clear(global.saveroom);

depth = -6;
hsp = 0;
vsp = 0;
grav = 0.5;
xscale = 1;
image_speed = 0.35;
state = pc_states.normal;
grounded = false;
targetDoor = "none";

canmove = true;

global.panic = false;
global.snickchallenge = false;

global.minutes = 0;
global.seconds = 59;
alarm[0] = room_speed;

global.collect = 0;

macht = 5;
machspd = 16;
normalspd = 6;

canmach = true;

canceljump = true;
taunting = false;
scared = false;
burger = false;

global.roomfrom = pc_titlescreen;
global.xfrom = xstart;
global.yfrom = ystart;

// sprites
character = "P";
scr_characterspr();
paletteselect = 1;

