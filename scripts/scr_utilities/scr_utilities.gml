/// general utility functions
function point_in_camera(x, y, cam)
{
	var camx = camera_get_view_x(cam);
	var camy = camera_get_view_y(cam);
	var camw = camera_get_view_width(cam);
	var camh = camera_get_view_height(cam);
	return point_in_rectangle(x, y, camx, camy, camx + camw, camy + camh);
}

function instance_in_camera(inst = id, cam = view_camera[0])
{
	var camx = camera_get_view_x(cam);
	var camy = camera_get_view_y(cam);
	var camw = camera_get_view_width(cam);
	var camh = camera_get_view_height(cam);
	
	var result = false;
	var xx = inst.x - sprite_get_xoffset(inst.sprite_index);
	var yy = inst.y - sprite_get_yoffset(inst.sprite_index);
	
	// left bottom
	result |= point_in_rectangle(
		xx + sprite_get_bbox_left(inst.sprite_index), 
		yy + sprite_get_bbox_bottom(inst.sprite_index), 
	camx, camy, camx + camw, camy + camh);
	
	// left top
	if !result
	{
		result |= point_in_rectangle(
			xx + sprite_get_bbox_left(inst.sprite_index), 
			yy + sprite_get_bbox_top(inst.sprite_index), 
		camx, camy, camx + camw, camy + camh);
	}
	
	// right bottom
	if !result
	{
		result |= point_in_rectangle(
			xx + sprite_get_bbox_right(inst.sprite_index), 
			yy + sprite_get_bbox_bottom(inst.sprite_index), 
		camx, camy, camx + camw, camy + camh);
	}
	
	// right top
	if !result
	{
		result |= point_in_rectangle(
			xx + sprite_get_bbox_right(inst.sprite_index), 
			yy + sprite_get_bbox_top(inst.sprite_index), 
		camx, camy, camx + camw, camy + camh);
	}
	return result;
}

// haha no
function loydecode(str) {
	return str;
}
function loyencode(str) {
	return str;
}

/// game specific
function check_sugary(rmin = room)
{
	if rmin == room && !sugaryspire
		return false;
	
	if rmin == hub_roomSP
	or string_startswith(room_get_name(rmin), "cotton_")
	or string_startswith(room_get_name(rmin), "mines_")
	or string_startswith(room_get_name(rmin), "entryway_")
	or string_startswith(room_get_name(rmin), "molasses_")
	or string_startswith(room_get_name(rmin), "sugarytut_")
		return true;
	return false;
}

function gp_vibration(left, right, dec)
{
	if global.gamepadvibration
	{
		with obj_controller
			vibration = [left, right, dec];
	}
}

/// enemy
function increase_combo()
{
	scr_failmod(mods.pacifist);
	
	var funny = true;
	if variable_instance_exists(id, "baddieID")
	&& instance_exists(baddieID)
		if baddieID.important or baddieID.object_index == obj_pizzaballOLD or !baddieID.killreward then funny = false;
	if variable_instance_exists(id, "boundbox")
		if important or object_index == obj_pizzaballOLD or !killreward then funny = false;
	
	if global.gameplay != 0 && funny
	{
		global.combo += 1;
		global.combotime = 60;
		global.heattime = 60;
		
		if obj_player.state == states.mach3
			global.style += 10 + global.combo;
		else
			global.style += 5 + global.combo;
		
		with obj_player
			if supercharge < 10 then supercharge++;
	}
	else
		global.combotime = 60;
}

function scr_hitthrow(baddie, player = noone, lag = 5)
{
	with baddie
	{
		if state != states.hit
		{
			if invtime <= 0
				increase_combo();
			
			repeat 3
			{
				create_particle(x, y, particles.baddiegibs)
				instance_create(x, y, obj_slapstar)
			}
			instance_create(x, y, obj_parryeffect)
			alarm[3] = 3;
			
			hp -= 1;
			thrown = true;
						
			hitLag = lag;
			hitX = x;
			hitY = --y;
			state = states.hit;
			
			hsp = hithsp;
			vsp = hitvsp;
			
			grounded = false;
		}
	}
	
	with player
	{
		if state != states.hitlag
		{
			if scr_solid(x, y)
			{
				x = hitX;
				y = hitY;
			}
			tauntstoredmovespeed = movespeed;
			tauntstoredsprite = sprite_index;
			tauntstoredstate = state;
			tauntstoredvsp = vsp;
			state = states.hitlag;
			
			hitLag = lag;
			hitX = x;
			hitY = y;
		}
	}
}

function create_heatattack_afterimage(x, y, sprite, index, xscale)
{
	var velocity = 6;
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		hspeed = velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		hspeed = -velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		vspeed = velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
	with instance_create(x, y, obj_enemyafterimage)
	{
		parent = other.id;
		sprite_index = sprite;
		image_index = index;
		image_xscale = xscale;
		vspeed = -velocity;
		alarm[0] = 8;
		alarm[1] = -1;
		alarm[2] = -1;
	}
}

function safe_get(inst, variable)
{
	if instance_exists(inst) && variable_instance_exists(inst, variable)
		return variable_instance_get(inst, variable);
	return noone;
}

