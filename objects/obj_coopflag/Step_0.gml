if !global.coop
{
	visible = false;
	exit;
}

var player = obj_player1;
if !player.spotlight
	player = obj_player2;

var flagspr = spr_flagpeppino
switch player.character
{
	default: flagspr = spr_flagpeppino; break;
	case "N": flagspr = spr_flagnoise; break;
}
	
x = player.x
y = player.y
image_xscale = player.xscale

if sprite_index != flagspr
{
	visible = true
	sprite_index = flagspr
		
	alarm[1] = -1
	alarm[0] = 150
	alarm[2] = 200
}

