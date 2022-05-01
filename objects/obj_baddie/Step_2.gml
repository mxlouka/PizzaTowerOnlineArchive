/// @description
if global.gameplay == 0 && hp > 1
	hp = 1;

// attempt to resolve instance region issue
if room == custom_lvl_room
{
	if boundbox && !place_meeting(x, y, obj_baddiecollisionbox)
	{
		var tryfix = true;
		with obj_baddiecollisionbox
		{
			if baddieID == other.id
				tryfix = false;
		}
		
		if tryfix
			boundbox = false;
	}
}

if thrown && state != states.hit
{
	with obj_destructibles
	{
		if place_meeting(x - other.hsp, y, other)
		{
			if scr_stylecheck(2)
				momentum[0] = other.hsp;
			instance_destroy();
		}
	}
	if abs(hsp) < 24 && grav == 0
		grav = 0.35;
}
if state != states.grabbed
{
	clipin = 60;
	scr_collide();
}
else if object_index != obj_tankOLD
	scr_enemy_grabbed();

if invtime > 0
	invtime--;

yscale = Approach(yscale, 1, 0.1);

// heat meter image speed and cloud effects
if global.gameplay != 0
{
	if state == states.walk
		image_speed = 0.35 + (global.baddiespeed * 0.05);
	if sprite_index == walkspr && hsp != 0 && grounded && floor(image_index) >= image_number - 1 && image_number > 1
		instance_create(x - image_xscale * 20, y + 43, obj_cloudeffect);
}

// inside a block
var sold = instance_place(x, y, obj_solid);
if sold && !inst_relation(sold, obj_slope)
{
	if state != states.grabbed && state != states.hit
	&& !inst_isobj(sold, obj_enemyblock)
	&& (!inst_relation(sold, obj_destructibles)
	or (inst_isobj(sold, obj_onewaybigblock) && sign(sold.image_xscale) == -sign(image_xscale)))
		instance_destroy();
}

// provoke
var targetplayer = obj_player;
if targetplayer && targetplayer.x > x - 400 && targetplayer.x < x + 400 && y <= targetplayer.y + 20 && y >= targetplayer.y - 20
&& targetplayer.state == states.backbreaker && state != states.pizzagoblinthrow
{
	stunned = 0;
	bombreset = 0;
	scaredbuffer = 0;
}

