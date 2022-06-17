var list = escape ? global.escaperoom : global.baddieroom;
if ds_list_find_index(list, id) != -1
	instance_destroy(id, false);
else
	event_user(0);

if elite && global.gameplay != 0
{
    hp += 1
    elitehp = hp
}

// snap to ground
if room != custom_lvl_room
{
	for(i = y; i < y + 64; i++)
	{
		if scr_solid(x, i + 1)
		{
			y = i;
			break;
		}
	}
}
