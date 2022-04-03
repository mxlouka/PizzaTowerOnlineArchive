function scr_panicbg_start() {
	//DDP This script is run every time the first background starts to draw
	if !check_shaders()
		exit;
	
	if !variable_global_exists("panicbg_surface") or !surface_exists(global.panicbg_surface) {
		global.panicbg_surface = surface_create(__view_get( e__VW.WView, 0 ) + 128, __view_get( e__VW.HView, 0 ) + 128)
	}
	global.panicbg_width = 960;

	if event_type == ev_draw and event_number == 0
	{
		// Render all background layers to panicbg_surface instead of application_surface
		surface_set_target(global.panicbg_surface);
		draw_clear_alpha(c_black, 0);
		
		// Offset each layer to account for scrolling
		var _cam_x = camera_get_view_x(view_camera[0])
		var _cam_y = camera_get_view_y(view_camera[0])
		
		for (var i = 0; i < array_length(global.roombgs); i++;)
		{
			if layer_get_depth(global.roombgs[i].lay) < 0
				continue;
			
			var lay = global.roombgs[i].lay;
			var bg = global.roombgs[i].bg;
			
			layer_x(lay, layer_get_x(lay) - _cam_x + 64)
			layer_y(lay, layer_get_y(lay) - _cam_y + 64)
			
			global.panicbg_width = max(global.panicbg_width, sprite_get_width(layer_background_get_sprite(bg)));
		}
	}
}

