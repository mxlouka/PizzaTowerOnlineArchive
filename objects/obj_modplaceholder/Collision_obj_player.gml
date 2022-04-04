if other.state == states.handstandjump
{
	scr_soundeffect(sfx_punch);
	with other
		scr_pummel();
	
	if global.modifier == mods.no_toppings
		global.modifier = -1;
	else
		global.modifier = mods.no_toppings;
}