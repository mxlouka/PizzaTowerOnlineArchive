/// @description controller vibration
if !connected
	exit;

if global.gamepadvibration
{
	// depending on new player state
	with obj_player
	{
		if other.prevstate != state
		{
			switch state
			{
				case states.tackle:
	                gp_vibration(0.8, 0.8, 0.6)
	                break
	            case states.tumble:
	                gp_vibration(0.8, 0.8, 0.8)
	                break
	            case states.fireass:
	                gp_vibration(1, 1, 0.85)
	                break
	            case states.firemouth:
	                gp_vibration(0.8, 0.8, 0.85)
	                break
	            case states.hurt:
	                gp_vibration(1, 1, 0.85)
	                break
	            case states.bombpep:
	                gp_vibration(0.8, 0.8, 0.6)
	                if sprite_index == spr_bombpepend
	                    gp_vibration(1, 1, 0.9)
	                break
	            case states.Sjump:
	                gp_vibration(0.8, 0.8, 0.85)
	                break
	            case states.Sjumpprep:
	                gp_vibration(0.8, 0.8, 0.6)
	                break
	            case states.Sjumpland:
	                gp_vibration(1, 1, 0.9)
	                break
	            case states.knightpep:
	                if sprite_index == spr_knightpepthunder
	                    gp_vibration(1, 1, 0.9)
	                break
	            case states.parry:
	                gp_vibration(0.8, 0.8, 0.65)
	                break
	            case states.freefallland:
	                gp_vibration(1, 1, 0.85)
	                break
	            case states.chainsaw:
	                gp_vibration(0.8, 0.8, 0.6)
	                break
	            case states.bump:
	                if sprite_index != spr_hitwall
	                    gp_vibration(0.8, 0.8, 0.6)
	                else
	                    gp_vibration(1, 1, 0.85)
	                break
	            case states.handstandjump:
	                gp_vibration(0.2, 0.2, 0.9)
	                break
	            case states.grab:
	                gp_vibration(0.2, 0.2, 0.8)
	                break
			}
		}
		other.prevstate = state;
	}
	
	// set the vibration
	if vibration[0] > 0 or vibration[1] > 0
	{
		vibration[0] *= vibration[2];
		vibration[1] *= vibration[2];
	
		if vibration[0] <= 0
			vibration[0] = 0;
		if vibration[1] <= 0
			vibration[1] = 0;
	}
	
	if global.cont2 == -1
		vibration2 = [0, 0, 0];
	else if vibration2[0] > 0 or vibration2[1] > 0
	{
		vibration2[0] *= vibration2[2];
		vibration2[1] *= vibration2[2];
	
		if vibration2[0] <= 0
			vibration2[0] = 0;
		if vibration2[1] <= 0
			vibration2[1] = 0;
	}
}
else
{
	vibration = [0, 0, 0];
	vibration2 = [0, 0, 0];
}

gamepad_set_vibration(global.cont, vibration[0], vibration[1]);
gamepad_set_vibration(global.cont2, vibration2[0], vibration2[1]);

