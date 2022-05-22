/// @description escape deactivate
if escape && (!global.panic or (global.gameplay == 0 && object_index != obj_minijohn && object_index != obj_babybear))
{
	boundbox = false;
	instance_deactivate_object(id);
}

