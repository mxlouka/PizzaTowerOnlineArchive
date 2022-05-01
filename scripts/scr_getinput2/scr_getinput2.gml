function scr_getinput2(force = false)
{
	with obj_player2
		online_busy = false;
	
	var cont = global.cont2;
	if ((instance_exists(obj_gms) && global.__chat)
	or (instance_exists(obj_manual) && obj_manual.visible)
	or (instance_exists(obj_wc) && (obj_wc.WC_consoleopen or obj_wc.WC_assetfinder > -1))
	or (instance_exists(obj_choicebase))
	or (instance_exists(obj_hubelevator) && obj_hubelevator.state == 1)
	or instance_exists(obj_dialoguebox))
	{
		with obj_player2
			online_busy = true;
		
		if !force
		{
			key_up = false
			key_up2 = false
			key_right = false
			key_right2 = false
			key_left = false
			key_left2 = false
			key_down = false
			key_down2 = false
			key_jump = false
			key_jump2 = false
			key_slap = false
			key_slap2 = false
			key_taunt = false
			key_taunt2 =  false
			key_attack = false
			key_attack2 = false
			key_shoot = false
			key_shoot2 = false
			key_start = false
			key_escape = false
		
			stickpressed = true;
			exit;
		}
	}
	
	if !variable_instance_exists(id, "stickpressed")
		stickpressed = true;
	
	// gamepad
	if cont > -1
	{
		var deadzone = 0.4
		gamepad_set_axis_deadzone(cont, deadzone)
		
		key_up |= gamepad_button_check(cont, global.key_upCN) or gamepad_axis_value(cont, gp_axislv) < 0;
		key_up2 |= gamepad_button_check_pressed(cont, global.key_upCN) or (gamepad_axis_value(cont, gp_axislv) < -deadzone && !stickpressed);
		key_right |= gamepad_button_check(cont, global.key_rightCN)  or gamepad_axis_value(cont, gp_axislh) > 0;
		key_right2 |= gamepad_button_check_pressed(cont, global.key_rightCN) or (gamepad_axis_value(cont, gp_axislh) > deadzone && !stickpressed);
		key_left |= -(gamepad_button_check(cont, global.key_leftCN) or gamepad_axis_value(cont, gp_axislh) < 0);
		key_left2 |= -(gamepad_button_check_pressed(cont, global.key_leftCN) or (gamepad_axis_value(cont, gp_axislh) < -deadzone && !stickpressed));
		key_down |= gamepad_button_check(cont, global.key_downCN) or gamepad_axis_value(cont, gp_axislv) > 0;
		key_down2 |= gamepad_button_check_pressed(cont, global.key_downCN) or (gamepad_axis_value(cont, gp_axislv) > deadzone && !stickpressed);
		key_jump |= gamepad_button_check_pressed(cont, global.key_jumpCN);
		key_jump2 |= gamepad_button_check(cont, global.key_jumpCN);
		key_slap |= gamepad_button_check(cont, global.key_slapCN);
		key_slap2 |= gamepad_button_check_pressed(cont, global.key_slapCN)
		key_taunt |= gamepad_button_check(cont, global.key_tauntCN)
		key_taunt2 |=  gamepad_button_check_pressed(cont, global.key_tauntCN)
		key_attack |= gamepad_button_check(cont, global.key_attackCN) or gamepad_button_check(cont, gp_shoulderrb)
		key_attack2 |= gamepad_button_check_pressed(cont, global.key_attackCN)  or gamepad_button_check_pressed(cont, gp_shoulderrb)
		key_shoot |= gamepad_button_check(cont, global.key_shootCN) 
		key_shoot2 |= gamepad_button_check_pressed(cont, global.key_shootCN) 
		key_start |= gamepad_button_check_pressed(cont, global.key_startCN) 
		key_escape |= gamepad_button_check(cont, gp_select)
		
		if (gamepad_axis_value(cont, gp_axislh) > deadzone or gamepad_axis_value(cont, gp_axislh) < -deadzone)
		or (gamepad_axis_value(cont, gp_axislv) > deadzone or gamepad_axis_value(cont, gp_axislv) < -deadzone)
			stickpressed = true;
		else
			stickpressed = false;
	}
	else
	{
		stickpressed = true;
		
		key_up = keyboard_check(global.key_upN)
		key_up2 = keyboard_check_pressed(global.key_upN)
		key_right = keyboard_check(global.key_rightN)
		key_right2 = keyboard_check_pressed(global.key_rightN)
		key_left = -keyboard_check(global.key_leftN)
		key_left2 = -keyboard_check_pressed(global.key_leftN)
		key_down = keyboard_check(global.key_downN)
		key_down2 = keyboard_check_pressed(global.key_downN)
		key_jump = keyboard_check_pressed(global.key_jumpN)
		key_jump2 = keyboard_check(global.key_jumpN)
		key_slap = keyboard_check(global.key_slapN)
		key_slap2 = keyboard_check_pressed(global.key_slapN)
		key_taunt = keyboard_check(global.key_tauntN)
		key_taunt2 =  keyboard_check_pressed(global.key_tauntN)
		key_attack = keyboard_check(global.key_attackN)
		key_attack2 = keyboard_check_pressed(global.key_attackN)
		key_shoot = keyboard_check(global.key_shootN)
		key_shoot2 = keyboard_check_pressed(global.key_shootN)
		key_start = keyboard_check_pressed(global.key_startN)
		key_escape = keyboard_check_pressed(vk_escape)
	}
}

