/// @description dont fucking drag it
with obj_wc
{
	if instance_exists(WC_dragobj) && WC_dragobj.id == other.id
		WC_dragobj = noone;
}
with obj_shell
{
	if instance_exists(WC_drag_inst) && WC_drag_inst.id == other.id
		WC_drag_inst = noone;
}
