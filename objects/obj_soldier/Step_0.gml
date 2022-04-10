if room == rm_editor exit;

switch (state)
{
    case states.idle: 
	if (sprite_index != spr_soldier_idleend)
		scr_enemy_idle (); 
	break;
 // case states.charge: scr_enemy_charge (); break;
    case states.turn: scr_enemy_turn (); break;
    case states.walk: scr_enemy_walk (); break;
    case states.land: scr_enemy_land (); break;
    case states.hit: scr_enemy_hit (); break;
    case states.stun: scr_enemy_stun (); break;
    case states.pizzagoblinthrow: scr_pizzagoblin_throw (); break;
	case states.rage: scr_enemy_rage (); break;
	case states.grabbed: scr_enemy_grabbed (); break;
}

if  state = states.stun && stunned > 100 && birdcreated = false
{
birdcreated = true
with instance_create(x,y, obj_enemybird)
ID = other.id
}

if state != states.stun
birdcreated = false

if state == states.walk && y != ystart && !scr_solid(x, y)
{
	y = Approach(y, ystart, 1);
	if scr_solid(x, y)
	{
		stuck = true;
		y = yprevious;
	}
	else
		stuck = false;
}

if state == states.stun
	grav = 0.5
else 
	grav = 0

//Flash
if (flash == true && alarm[2] <= 0) {
   alarm[2] = 0.15 * room_speed; // Flashes for 0.8 seconds before turning back to normal
}

if state != states.grabbed
	depth = 0
	
if state != states.charge
	scr_scareenemy()
var player = instance_nearest(x, y, obj_player)

switch state
{
    case states.idle:
        if bush
        {
            var col = collision_line(x, y, player.x, player.y, obj_solid, false, true)
            var col2 = collision_line(x, y, player.x, player.y, obj_slope, false, true)
            var colX = (player.x > (x - threshold_x) && player.x < (x + threshold_x))
            var colY = (player.y > (y - threshold_y) && player.y < (y + threshold_y))
            if (sprite_index != scaredspr && col == -4 && col2 == -4 && colX && colY)
            {
                if (x != player.x)
                    image_xscale = sign((player.x - x))
                bush = 0
                sprite_index = spr_soldier_idleend
                image_index = 0
            }
        }
        else if (sprite_index == spr_soldier_idleend && floor(image_index) == (image_number - 1))
        {
            state = states.walk
            sprite_index = spr_soldier_walk
        }
        break
    case states.charge:
        hsp = Approach(hsp, 0, 0.5)
        if (sprite_index == spr_soldier_shootstart && floor(image_index) == (image_number - 1))
            sprite_index = spr_soldier_shoot
        if (sprite_index != spr_soldier_shootstart)
        {
            if (bullet_count > 0)
            {
                if can_fire
                {
					scr_soundeffect(sfx_killingblow)
                    can_fire = 0
                    alarm[5] = fire_max
					
                    bullet_count--
                    sprite_index = spr_soldier_shoot
                    image_index = 0
                    hsp -= (image_xscale * recoil_spd)
                    with (instance_create(x, y, obj_enemybullet))
                        image_xscale = other.image_xscale
                }
            }
            else if (floor(image_index) == (image_number - 1))
            {
                sprite_index = walkspr
                attack_cooldown = attack_max
                state = states.walk
            }
        }
        break
    case states.walk:
        if (attack_cooldown > 0)
            attack_cooldown--
        else
        {
            col = collision_line(x, y, player.x, player.y, obj_solid, false, true)
            col2 = collision_line(x, y, player.x, player.y, obj_slope, false, true)
            colX = (player.x > (x - threshold_x) && player.x < (x + threshold_x))
            colY = (player.y > (y - threshold_y) && player.y < (y + threshold_y))
            if (sprite_index != scaredspr && col == -4 && col2 == -4 && colX && colY)
            {
                if (x != player.x)
                    image_xscale = sign((player.x - x))
                sprite_index = spr_soldier_shootstart
                image_index = 0
                state = states.charge
                bullet_count = bullet_max
                can_fire = 1
            }
        }
        break
}
if state != states.grabbed
    depth = 0
if state != states.stun
    thrown = 0
if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index
        mask_index = other.sprite_index
        baddieID = other.id
        other.boundbox = 1
    }
}
