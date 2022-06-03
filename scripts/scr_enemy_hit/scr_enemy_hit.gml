function scr_enemy_hit()
{
	x = hitX + random_range(-4, 4);
	y = hitY + random_range(-4, 4);
	hitLag--;
	sprite_index = stunfallspr;
	
	if hitLag <= 0
	{
		x = hitX;
		y = hitY;
		state = states.stun;
		
		with obj_player
		{
			if baddiegrabbedID == other.id
				other.state = states.grabbed;
		}
		
		vsp = hitvsp;
		hsp = hithsp;
		
		global.combotime = 60;
		global.heattime = 60;
		alarm[1] = 5;
		stunned = 200;
		thrown = true;
		
		if hp < -6 && object_index != obj_pizzaballOLD && (!scr_stylecheck(2) or killprotection)/* && object_get_parent(object_index) != par_boss*/
			instance_destroy();
	}
}

