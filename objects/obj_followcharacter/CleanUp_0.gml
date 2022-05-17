var find = ds_list_find_index(global.followerlist, id);
if find != -1
{
	ds_list_delete(global.followerlist, find);
	with obj_followcharacter
	{
		if followid == id followid = other.followid;
		if instance_exists(followid)
			pos = followid.pos + 1;
		else
			pos = 0;
	}
}

