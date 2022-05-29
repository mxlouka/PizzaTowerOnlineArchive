/// @description
scr_get_muname(img_index)
music_editor = asset_get_index(name)

if !audio_is_playing(global.jukebox)
{
    audio_stop_sound(global.music)
    with obj_music
        alarm[0] = 1
}

