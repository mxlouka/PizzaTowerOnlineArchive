if state == states.hang
	state = states.normal;

if place_meeting(x, y + 1, obj_boxofpizza) or place_meeting(x, y - 1, obj_boxofpizza)
{
	box = true;
	hallway = false;
	state = states.crouchjump;
	jumpstop = true;
}

if !oldhallway
{
	var doortarget = noone;
	if targetDoor == "A"
		doortarget = obj_doorA;
	else if targetDoor == "B"
		doortarget = obj_doorB;
	else if targetDoor == "C"
		doortarget = obj_doorC;
	else if targetDoor == "D"
		doortarget = obj_doorD;
	else if targetDoor == "E"
		doortarget = obj_doorE;
	
	if !instance_exists(doortarget) && instance_exists(obj_doorANY)
	{
		with obj_doorANY
			if door == other.targetDoor doortarget = id;
	}
	
	if instance_exists(doortarget)
	{
		if hallway
			x = doortarget.x + (hallwaydirection * 100);
		else if box
			x = doortarget.x + 32;
		else if verticalhallway
		{
			x = doortarget.x + vhallwaypos;
			if scr_solid_player(x, y)
				x = doortarget.x + 18;
		}
		else
			x = doortarget.x + 18;
		y = doortarget.y - 14;
		
		if targetDoor == "A" && place_meeting(x, y, obj_exitgate)
			x -= 18;
	}
	
	// avoid spawning inside of a hallway
	var hallwayprotect = instance_place(x, y, obj_hallway);
	if hallwayprotect && hallwayprotect.image_xscale != 0
	{
		xscale = sign(-hallwayprotect.image_xscale);
		x += xscale * 100;
	}
	
	if verticalhallway
		y += vhallwaydirection * 50;
	
	if is_real(targetDoor)
	{
		if !audio_is_playing(global.music)
		{
			with obj_music
				wait = true;
		}
		
		with obj_teleporter
		{
			if trigger == other.targetDoor && !start
			{
				player.x = x
				player.y = y - 14
				alarm[1] = 15;
			}
		}
	}
}
else
{
	x = target_x
	y = target_y
}

// snap to wall if climbing
if state == states.climbwall
{
	var xx = x;
	while !scr_solid(x + xscale, y)
	{
		x += xscale;
		if abs(x) > room_width
		{
			x = xx;
			break;
		}
	}
}

// dont fall off the ladder Please
if state == states.ladder
	doorx = x;

if box
	grounded = false;

hallway = false
verticalhallway = false
box = false
oldhallway = false

roomstartx = x
roomstarty = y
hitX = x
hitY = y

// bringing baddies through rooms (rest of the code is in obj_fadeout)
if baddiegrabbedID != 0 && baddiegrabbedID != obj_null && baddiegrabbedID != obj_otherplayer
{
	with baddiegrabbedID
		persistent = false;
	with obj_baddiecollisionbox
		if baddieID == other.baddiegrabbedID
			persistent = false;
}

