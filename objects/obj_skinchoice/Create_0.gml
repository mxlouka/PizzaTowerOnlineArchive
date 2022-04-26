event_inherited();
noisetype = 0;
sel = [1, "P"];

palcolors = ds_list_create();
palsurf = -1;

with obj_player
{
	other.noisetype = noisetype;
	other.sel = [paletteselect, character];
}
selvert = true;

spr_idle = -1;
spr_select = -1;

event_user(0);
selected = false;

