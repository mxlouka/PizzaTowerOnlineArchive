if room == rm_editor exit;

switch (state)
{
    case states.idle: scr_enemy_idle (); break;
    case states.charge: scr_enemy_charge (); break;
    case states.turn: scr_enemy_turn (); break;
    case states.walk: scr_enemy_walk (); break;
    case states.land: scr_enemy_land (); break;
    case states.hit: scr_enemy_hit (); break;
    case states.stun: scr_enemy_stun (); break;
    case states.pizzagoblinthrow: scr_pizzagoblin_throw (); break;
    // grabbed state here
}
if state == states.stun && stunned > 100 && !birdcreated
{
	birdcreated = true
	with instance_create(x,y, obj_enemybird)
		ID = other.id
}

if state != states.stun
	birdcreated = false

// float back to initial position
if state == states.walk && y != ystart
{
	var yes = Approach(y, ystart, 1);
	if !scr_solid(x, yes)
		y = yes;
}

if state == states.stun
	grav = 0.5
else 
	grav = 0

if laserbuffer > 0 && state == states.walk && global.gameplay == 0
	laserbuffer--
if bombreset > 0 && state == states.walk && global.gameplay != 0
    bombreset--

//Create laser
var player = instance_nearest(x, y, obj_player)
if global.gameplay != 0
{
	if player.x > x - 200 && player.x < x + 200 && player.y <= y + 400 && player.y >= y - 60
	&& x != player.x && state != states.pizzagoblinthrow && bombreset <= 0
    {
        if state == states.walk or state == states.idle
        {
            sprite_index = spr_ufolive_shoot
            image_index = 0
            state = states.pizzagoblinthrow
        }
    }
	
	if state == states.pizzagoblinthrow or state == states.rage
	{
	    hsp = 0
	    vsp = 0
	}
}
else if laserbuffer <= 0 && state == states.walk
{
	var laser = instance_create(x, y, obj_warplaser)
	laser.vsp = 2;
	
	laserbuffer = 100
}

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 0.15 * room_speed; // Flashes for 0.8 seconds before turning back to normal
}

if state != states.grabbed
	depth = 0

//Scared
scr_scareenemy()

if state != states.stun
	thrown = false

if !boundbox
{
	with instance_create(x, y, obj_baddiecollisionbox)
	{
		sprite_index = other.sprite_index
		mask_index = sprite_index
		baddieID = other.id
		other.boundbox = true
	}
}

