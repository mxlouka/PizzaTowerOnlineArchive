if ds_list_find_index(global.saveroom, id) == -1
{
	var instancelist = ds_list_create();
	for(var j = 0; j < array_length(objects); j++)
	{
		var l = instance_place_list(x, y, objects[j], instancelist, false);
		for(var i = 0; i < l; i++)
		{
			var obj = instancelist[| i];
			if ds_list_find_index(deactivatedlist, obj.id) == -1
			{
				switch objects[j]
				{
					case obj_baddie:
						obj.boundbox = false;
						obj.hitboxcreate = false;
						break;
				}
				instance_deactivate_object(obj);
			}
		}
	}
	ds_list_destroy(instancelist);
}
else
	instance_destroy();
