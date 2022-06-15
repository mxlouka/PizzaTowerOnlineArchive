if state == states.hang
	state = states.normal;

with obj_secretportal
{
    if secret
    {
        if !instance_exists(obj_ghostcollectibles)
            instance_create(0, 0, obj_ghostcollectibles)
    }
}

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
	with obj_doorPARENT
		if door == other.targetDoor doortarget = id;
	
	if instance_exists(doortarget)
	{
		y = doortarget.y - 14;
		if hallway
			x = doortarget.x + (hallwaydirection * 100);
		else if box
			x = doortarget.x + 32;
		else if verticalhallway
		{
			var hw = 32;
			with doortarget
			{
				var vh = instance_place(x, y, obj_verticalhallway);
				if vh
				{
					x = vh.x;
					hw = vh.sprite_width;
				}
			}
			
			x = doortarget.x + floor(vhallwaypos * hw);
			if scr_solid_player(x, y)
				x = doortarget.x + 18;
		}
		else
			x = doortarget.x + 18;
		
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

if isgustavo
    brick = true

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
