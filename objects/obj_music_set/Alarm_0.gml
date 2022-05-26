/// @description
scr_get_muname(image_index)
music_editor = asset_get_index(name)

if instance_exists(obj_editorsettings_menu) && !audio_is_playing(global.jukebox)
{
	audio_stop_all()
	with obj_music
		alarm[0] = 1
}