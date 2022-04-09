/// @description other??
if !patron
	global.gameplay = 0;

// nuh uh! you are NOT touching the pufferfish
if character == "PUFFER" && !debug
{
	room_goto(room_of_dog);
	exit;
}

// pizzelle new grab sprite
if character == "SP"
{
	if global.gameplay == 0
		spr_suplexdash = spr_playerSP_suplexdash;
	else
		spr_suplexdash = spr_playerSP_suplexdash_NEW;
}

// konami shit
if character == "PP" && !global.timeattack && state != states.backbreaker
{
	switch keyboard_lastkey
	{
		case vk_up:
			konami += "U";
			break;
		case vk_down:
			konami += "D";
			break;
		case vk_left:
			konami += "L";
			break;
		case vk_right:
			konami += "R";
			break;
		case global.key_jump:
			konami += "A";
			break;
		case global.key_slap:
			konami += "B";
			break;
	}
	if konami != "" && string_copy(konamiend, 1, string_length(konami)) != konami
		konami = "";
		
	if konami == konamiend
	{
		scr_soundeffect(sfx_vineboom);
		alarm[8] = 10;
		state = states.backbreaker;
		scr_baddie_screenclear();
		sprite_index = spr_playerPP_marior;
		
		keyboard_clear(keyboard_lastkey);
		konami = "";
	}
	keyboard_lastkey = -1;
}
