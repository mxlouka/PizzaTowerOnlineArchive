// clean ups prevent memory leaks
ds_list_destroy(tvprompts_list);
if surface_exists(promptsurface)
	surface_free(promptsurface);

