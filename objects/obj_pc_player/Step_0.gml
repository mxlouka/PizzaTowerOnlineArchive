scr_getinput();
if canmove && state != pc_states.pipe
{
	move = key_left + key_right;
	if move != 0
	{
		if (move == 1 && hsp < 0) or (move == -1 && hsp > 0)
			hsp += 0.5 * move;
		
		xscale = move;
		if state == pc_states.normal && grounded
			sprite_index = spr_move;
		if state == pc_states.crouch && grounded
			sprite_index = spr_crawl;
		
		if state != pc_states.mach4
		{
			if (move == 1 && hsp < normalspd) or (move == -1 && hsp > -normalspd)
				hsp += 0.5 * move;
			else if state != pc_states.revolver
				hsp -= 0.5 * move;
		}
		else
		{
			if (move == 1 && hsp < machspd) or (move == -1 && hsp > -machspd)
				hsp += 0.5 * move;
			else if character != "N"
				hsp -= 0.5 * move;
		}
	}
	else if state != pc_states.ice
	{
		if state == pc_states.normal
			sprite_index = spr_idle;
		if state == pc_states.crouch
			sprite_index = spr_crouch;
		if abs(hsp) > 1
			hsp += 0.5 * (sign(hsp) * -1); // replace xscale with sign(hsp) to fix strat
		else
			hsp = 0;
	}
	
	// mach
	if key_attack && (move != 0 or character == "N") && canmach
	{
		if state == pc_states.normal
		{
			sprite_index = spr_mach;
			state = pc_states.mach4;
		}
	}
	else if state == pc_states.mach4
	{
		audio_stop_sound(sfx_mach2);
		audio_stop_sound(sfx_mach3);
		
		state = pc_states.normal;
		image_blend = c_white;
	}
	
	// double jump
	if key_jump && character == "N" && (sprite_index == spr_jump or sprite_index == spr_fall)
	{
		sprite_index = spr_playerN_doublejump;
		image_index = 0;
		image_speed = 0.35;
		audio_play_sound(sfx_woosh, 0, false);
		vsp = -9 * sign(grav);
	}
	
	// jump
	if key_jump && grounded && state != pc_states.jump
	{
		if !(character == "N" && state == pc_states.mach4)
		{
			canceljump = true;
			
			sprite_index = spr_jump;
			if state == pc_states.crouch
				sprite_index = spr_crouchjump;
			image_index = 0;
			image_speed = 0.35;
			grounded = false;
			vsp = -11 * sign(grav);
			if state == pc_states.crouch
				vsp = -8 * sign(grav);
			if state != pc_states.mach4
				state = pc_states.jump;
			else
				vsp = -14 * sign(grav);
			
			audio_play_sound(sfx_jump, 0, false);
		}
	}
	
	if grounded
		canceljump = true;
	if grounded && state == pc_states.jump
	{
		state = pc_states.normal;
		normalspd = 6;
	}
	if !grounded && state == pc_states.normal
	{
		state = pc_states.jump;
		if sprite_index != spr_jump && sprite_index != spr_hurt
			sprite_index = spr_fall;
	}
	
	// gun
	if (key_slap2 or (keyboard_check(ord("S")) && debug)) && character == "V" && canmach
	{
		audio_stop_sound(sfx_killingblow);
		
		audio_stop_sound(sfx_mach2);
		audio_stop_sound(sfx_mach3);
		
		sprite_index = spr_playerV_revolvershoot;
		state = pc_states.revolver;
		image_index = 0;
		if !grounded
			vsp = -4 * sign(grav);
		audio_play_sound(sfx_killingblow, 0, false);
		instance_create_depth(x + (image_xscale * 20), y + 20, depth + 1, obj_shotgunbullet);
	}
	
	// taunt
	if key_taunt2 && !taunting && canmach
	{
		audio_stop_sound(sfx_mach2);
		audio_stop_sound(sfx_mach3);
		audio_play_sound(sfx_taunt, 0, false);
		taunting = true;
		alarm[2] = 15;
	}
}

if !taunting
{
	switch(state)
	{
		case pc_states.normal:
			if sprite_index == spr_idle
				image_speed = 0.35;
			else if sprite_index == spr_move
			{
				image_speed = abs(hsp) / 10;
				image_speed = max(image_speed, 0.35);
			}
			mask_index = spr_player_mask;
		
			if key_down
			{
				state = pc_states.crouch;
				normalspd = 4;
			}
			break;
		
		case pc_states.jump:
			image_speed = 0.35;
			
			if !((sign(grav) == 1 && vsp <= 0) or (sign(grav) == -1 && vsp >= 0)) or round(abs(vsp)) == 0
				canceljump = false;
			
			if !key_jump2 && canceljump
				vsp = 0;
			break;
		
		case pc_states.mach4:
			if abs(hsp) < machspd - 1
			{
				sprite_index = spr_mach;
				image_speed = 0.35;
			}
			else
			{
				sprite_index = spr_mach4;
				image_speed = 0.5;
			}
			
			if character != "N"
			{
				if !((sign(grav) == 1 && vsp <= 0) or (sign(grav) == -1 && vsp >= 0)) or round(abs(vsp)) == 0
					canceljump = false;
			
				if !key_jump2 && canceljump
					vsp = 0;
			
				if abs(hsp) < machspd - 1 or !grounded
				{
					if !audio_is_playing(sfx_mach2)
						audio_play_sound(sfx_mach2, 0, false);
					audio_stop_sound(sfx_mach3);
				}
				else
				{
					if !audio_is_playing(sfx_mach3)
						audio_play_sound(sfx_mach3, 0, false);
					audio_stop_sound(sfx_mach2);
				}
			}
			else
			{
				if grounded
				{
					if move != 0
						hsp += 3 * xscale;
					vsp = -7.5;
					if key_jump2 && canceljump
						vsp = -14;
					if key_down && canceljump
						vsp = -3.5;
					audio_play_sound(sfx_Npogo3, 0, false);
					grounded = false;
				}
				else if move != 0 && abs(hsp) < 24
					hsp += 0.1 * xscale;
			}
			mask_index = spr_player_mask;
		
			if macht <= 0
			{
				instance_create_depth(x, y, depth + 1, obj_pc_machtrail);
				macht = 5;
			}
			else
				macht -= 1;
			break;
		
		case pc_states.dead:
			hsp = 0;
			vsp = 0;
			canmove = false;
			visible = false;
			mask_index = -1;
			break;
		
		case pc_states.floatup:
			canmove = false;
			vsp -= 0.2;
			y += vsp;
			image_speed = vsp / 20;
			break;
		
		case pc_states.revolver:
			sprite_index = spr_playerV_revolvershoot;
			image_speed = 0.4;
			break;
		
		case pc_states.crouch:
			image_speed = 0.45;
			mask_index = spr_crouchmask;
			if !key_down
			{
				state = pc_states.normal;
				normalspd = 6;
				mask_index = spr_player_mask;
			}
			break;
		
		case pc_states.ice:
			canmove = false;
			
			if abs(hsp) > 1
				hsp += 0.25 * -xscale;
			else
				hsp = 0;
			
			if hsp == 0 or place_meeting(x, y, obj_boilingsauce)
			{
				if place_meeting(x, y, obj_boilingsauce)
					vsp = -10;
				canmove = true;
				state = pc_states.normal;
				normalspd = 6;
				mask_index = spr_player_mask;
			}
			break;
		
		case pc_states.pipe:
			sprite_index = spr_idle;
			image_speed = 0;
			image_index = 0;
			xscale = 1;
			image_angle = point_direction(x, y, x + hspeed, y + vspeed);
			break;
	}
}

if state != pc_states.floatup && state != pc_states.CAUGHTYOU && state != pc_states.dead && state != pc_states.pipe && !taunting
	scr_collide_player_pc();

if sprite_index == spr_hurt && global.collect > 0 && irandom_range(0, 10) == 0
{
	with instance_create_depth(x, y, depth + 1, obj_pizzaloss)
	{
		vsp = random_range(0, -10);
		hsp = random_range(-10, 10);
	}
}

if taunting
	image_index -= image_speed;

// debug win
if keyboard_check_pressed(vk_f1) && debug
	instance_create_depth(0, 0, 0, obj_levelendfade);

// restarte
if keyboard_check_pressed(ord("R")) && (!(global.snickchallenge && global.seconds <= 0 && global.minutes <= 0) or debug)
{
	if (room != pc_titlescreen) or debug
	{
		if keyboard_check(vk_control)
		{
			audio_stop_all();
			room_goto(pc_titlescreen);
		}
		else if (grounded && canmove && !string_startswith(room_get_name(room), "hardlevel")) or debug
			room_restart();
	}
}

