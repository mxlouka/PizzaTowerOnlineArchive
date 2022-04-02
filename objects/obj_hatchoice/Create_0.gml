event_inherited();

selarray = [
	[spr_nohat, "Empty", "Don't you already have a hat?"],
	[spr_cowboyhat1, "Cowboy Hat", "Yeehaw."],
	[spr_hat_snickcrown, "Snick Crown", "For the king of the 4 Snicks."],
	[spr_hat_cowboy2, "Sheriff Hat", "Weirdly western."],
	[spr_hat_scatman, "JPEG Top Hat", "It smells like a public bathroom."]
];
spr_idle = selarray[0][0];

with obj_player
{
	// auto select current hat
	if hatsprite != -1
	{
		for(var i = 0; i < array_length(other.selarray); i++)
		{
			if other.selarray[i][0] == hatsprite
			{
				other.sel[0] = i;
				break;
			}
		}
	}
}

selvert = false;
event_user(0);