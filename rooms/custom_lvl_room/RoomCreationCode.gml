if !instance_exists(obj_onlinemenu)
	exit;

with all
{
	if variable_instance_exists(id, "__l_e_")
		instance_destroy(id, false);
}
if !audio_is_playing(global.jukebox)
	audio_stop_sound(global.music);

var loads = scr_loadlevel(obj_onlinemenu.level_string);
if loads <= 0 && (!debug or loads == -4)
{
	scr_playerreset();
	with obj_onlinemenu
		gameplay_chosen = -1;
	with obj_player
	{
		targetDoor = "B";
		state = states.titlescreen;
	}
	
	room_goto(editor_entrance);
	exit;
}

with obj_solid
{
	if object_index == obj_solid
	{
		if !position_meeting(x, y, obj_tiles)
			visible = true;
	}
}

#region image index 0

with obj_boilingsauce {
	image_index = 0;
}
with obj_destructibleplatform {
	image_index = 0;
}
with obj_spike {
	image_index = 0;
}
with obj_collect {
	image_index = 0;
}
with obj_bigcollect {
	image_index = 0;
}
with obj_giantcollect {
	image_index = 0;
}
with obj_minipillar {
	image_index = 0;
}
with obj_reverseminipillar {
	image_index = 0;
}
with obj_water_editor {
	image_index = 0;
}
with obj_current_editor {
	image_index = 0;
}
with obj_dashpad {
	image_index = 0;
}

#endregion

if !instance_exists(obj_escapetimer)
    instance_create_layer(128, 0, "Instances", obj_escapetimer)

global.coop = false
if obj_onlinemenu.menu != -1
{
	obj_onlinemenu.menu = -1;
	global.checkpointDoor = "B"
	global.checkpointroom = editor_entrance
	scr_setcoin(0);
}