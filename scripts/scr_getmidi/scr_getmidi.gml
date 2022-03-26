function scr_getmidi(mus)
{
	// placeholders
	if mus == mu_antonpunchball
		mus = mu_antonlevel_pc;
	else if mus == mu_hub2
		mus = mu_characterselect_pc;
	else if mus == mu_snickentrance or mus == mu_vigientrance
		mus = mu_entrance_pc;
	else if mus == mu_susgolf
		mus = mu_minigolf_pc;
	else if mus == mu_dungeondepth_re
		mus = mu_dungeondepth_pc;
	else if mus == mu_mall
		mus = mu_mall;
	else
	{
		// replace the sound
		if asset_get_type(audio_get_name(mus) + "_pc") == asset_sound
			mus = asset_get_index(audio_get_name(mus) + "_pc");
		else
			mus = mu_characterselect_pc;
	}
	return mus;
}
