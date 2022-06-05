function scr_wc_create()
{
	depth = power(2, 31) - 1;
	WC_debug = false;
	
	// instance drag
	WC_drag_toggle = !instance_exists(obj_wc);
	WC_drag_alt = false;
	WC_drag_offset = [0, 0];
	WC_drag_grid = [1, 1];
	WC_drag_inst = noone;
	WC_drag_deleting = false;
	
	// windows
	WC_win_list = ds_list_create();
	function WCwin(x = 0, y = 0, title = "Untitled") constructor
	{
		// vars
		win_x = x;
		win_y = y;
		win_width = 160;
		win_height = 90;
		win_surf = -1;
		win_title = title;
		
		win_moving = false;
		win_resize = false;
		
		// func
		draw = function()
		{
		
		}
		
		function add() {
			ds_list_add(obj_shell.WC_win_list, self);
		}
	}
	WC_win_focus = -1;
	WC_win_dragx = 0;
	WC_win_dragy = 0;
	
	// funcs
	function WCscr_overconsole()
	{
		var mx = device_mouse_x_to_gui(0), my = device_mouse_y_to_gui(0);
		return isOpen && mx >= shellOriginX && my >= shellOriginY && mx < shellOriginX + width && my < shellOriginY + height;
	}
	
	function WCscr_findobj(obj)
	{
		var target_one = false;
		var target = noone;
	
		if obj == "all"
		{
			// every instance
			target = all;
		}
		else if asset_get_type(obj) == asset_object
		{
			// just an object
			var asset = asset_get_index(obj);
			if instance_exists(asset)
				target = asset;
		}
		else
		{
			// possibly a specific object
			if string_pos(":", obj) > 0
			{
				// parse object and index
				var parse_obj = "";
				var parse_ind = "";
				var parsing = 0;
				
				for(var i = 1; i <= string_length(obj); i++)
				{
					var char = string_char_at(obj, i);
					
					// obj part
					if parsing == 0
					{
						if char == ":"
						{
							parsing = 1;
							continue;
						}
						parse_obj += char;
					}
					
					// index part
					else
						parse_ind += char;
				}
				
				// verify that index is number
				if string_digits(parse_ind) != parse_ind
					return "Instance index must be a number";
				parse_ind = real(parse_ind);
				
				// get object
				var asset = noone;
				if string_digits(parse_obj) == parse_obj
					asset = real(parse_obj);
				else if asset_get_type(parse_obj) == asset_object
					asset = asset_get_index(parse_obj);
			
				if instance_exists(asset)
				{
					target_one = true;
					
					// get specific instance
					asset = instance_find(asset, parse_ind);
					if instance_exists(asset)
						target = asset;
				}
			}
			// or just an object, by number
			else if string_digits(obj) == obj && obj != ""
			{
				if instance_exists(real(obj))
					target = real(obj);
			}
		}
		return [target, target_one];
	}
	
	function WCscr_allargs(args, after = 0)
	{
		var ret = "";
		for(var i = after; i < ds_list_size(args); i++)
			ret += args[|i] + (i == ds_list_size(args) - 1 ? "" : " ");
		return ret;
	}
}

function scr_wc_step()
{
	if debug
		WC_debug = true;
	
	if display_mouse_get_x() > window_get_x() && display_mouse_get_x() < window_get_x() + window_get_width()
	&& display_mouse_get_y() > window_get_y() && display_mouse_get_y() < window_get_y() + window_get_height()
		window_set_cursor(cr_default);
	
	// alternative key to open the console
	if keyboard_check_pressed(220) && !instance_exists(obj_wc)
	{
		if !isOpen
			self.open();
		else
			self.close();
	}
	
	// focus on a window
	var mousex = device_mouse_x_to_gui(0), mousey = device_mouse_y_to_gui(0);
	if mouse_check_button_pressed(mb_left)
	{
		WC_win_focus = -1;
		if !WCscr_overconsole()
		{
			for(var i = 0; i < ds_list_size(WC_win_list); i++)
			{
				var win = WC_win_list[|i];
				if mousex >= win.win_x && mousex < win.win_x + win.win_width + 4
				&& mousey >= win.win_y - 32 && mousey < win.win_y + win.win_height + 4
				{
					WC_win_focus = win;
					break;
				}
			}
		}
	}
	
	// drag objects
	if WC_drag_toggle && WC_debug
	{
		// object gone failsafe
		if !instance_exists(WC_drag_inst)
			WC_drag_inst = noone;
		
		// start dragging an object
		var mb = mouse_check_button_pressed(mb_left) - mouse_check_button_pressed(mb_middle);
		if mb != 0 && WC_win_focus == -1 && !WCscr_overconsole() && !instance_exists(WC_drag_inst)
		{
			// drag player
			if mb == 1 && keyboard_check(vk_control) && instance_exists(obj_player1)
			{
				WC_drag_offset = [0, 0];
				WC_drag_alt = keyboard_check(vk_alt);
				WC_drag_inst = instance_find(obj_player1, 0);
			}
			// normal drag
			else
			{
				WC_drag_inst = collision_point(mouse_x, mouse_y, all, true, false);
				if instance_exists(WC_drag_inst)
				{
					// prioritize baddie (pt exclusive)
					if WC_drag_inst.object_index == obj_baddiecollisionbox
					&& instance_exists(WC_drag_inst.baddieID)
						WC_drag_inst = WC_drag_inst.baddieID;
					
					// vars
					WC_drag_offset = [mouse_x - WC_drag_inst.x, mouse_y - WC_drag_inst.y];
					WC_drag_alt = keyboard_check(vk_alt);
					
					// duplicate
					if mb == -1
					{
						with WC_drag_inst
							other.WC_drag_inst = instance_copy(keyboard_check(vk_control));
					}
				}
			}
		}
	
		// mass delete
		if WC_drag_inst == noone && keyboard_check(vk_control) && mouse_check_button_pressed(mb_right)
			WC_drag_deleting = true;
		
		if WC_drag_deleting
		{
			if !mouse_check_button(mb_right)
				WC_drag_deleting = false;
		
			var delinst = collision_point(mouse_x, mouse_y, all, true, false);
			if instance_exists(delinst)
				instance_destroy(delinst, !keyboard_check(vk_alt));
		}
		
		// actually drag the object
		if instance_exists(WC_drag_inst)
		{
			var rel = (!mouse_check_button(mb_middle) && mouse_check_button_released(mb_left)) or (!mouse_check_button(mb_left) && mouse_check_button_released(mb_middle));
		
			// move the object
			if !WC_drag_alt or rel
			{
				with WC_drag_inst
				{
					// handle grid
					x = floor((mouse_x - other.WC_drag_offset[0]) / other.WC_drag_grid[0]) * other.WC_drag_grid[0];
					y = floor((mouse_y - other.WC_drag_offset[1]) / other.WC_drag_grid[1]) * other.WC_drag_grid[1];
				
					// drag other player in pto
					if object_index == obj_otherplayer
						gms_p2p_send(p2p.wcdrag, player_id, x, y);
				}
				
				// handle frozen position
				
			}
			
			// delete or cancel
			if rel
				WC_drag_inst = noone;
			else if mouse_check_button_pressed(mb_right) && WC_drag_inst != noone
			{
				if !WC_drag_alt
					instance_destroy(WC_drag_inst, !keyboard_check(vk_control));
				WC_drag_inst = noone;
			}
			
			// duplicate
			else if (mouse_check_button(mb_left) && mouse_check_button_pressed(mb_middle))
			or (keyboard_check(vk_control) && mouse_check_button(mb_middle))
			{
				var copy = noone;
				with WC_drag_inst
					copy = instance_copy(false);
				
				if WC_drag_alt
				{
					with copy
					{
						x = floor((mouse_x - other.WC_drag_offset[0]) / other.WC_drag_grid[0]) * other.WC_drag_grid[0];
						y = floor((mouse_y - other.WC_drag_offset[1]) / other.WC_drag_grid[1]) * other.WC_drag_grid[1];
					}
				}
			}
		}
	}
	else
		WC_drag_inst = noone;
}

function scr_wc_draw()
{
	if instance_exists(WC_drag_inst)
	{
		with WC_drag_inst
		{
			var xp = x, yp = y;
		
			x = floor((mouse_x - other.WC_drag_offset[0]) / other.WC_drag_grid[0]) * other.WC_drag_grid[0];
			y = floor((mouse_y - other.WC_drag_offset[1]) / other.WC_drag_grid[1]) * other.WC_drag_grid[1];
		}
		
		// draw spr
		var xscale = WC_drag_inst.image_xscale, yscale = WC_drag_inst.image_yscale;
		if variable_instance_exists(WC_drag_inst, "xscale")
			xscale = WC_drag_inst.xscale;
		if variable_instance_exists(WC_drag_inst, "yscale")
			yscale = WC_drag_inst.yscale;
		draw_sprite_ext(WC_drag_inst.sprite_index, WC_drag_inst.image_index, WC_drag_inst.x, WC_drag_inst.y, xscale, yscale, WC_drag_inst.image_angle, WC_drag_inst.image_blend, 0.75);
		
		// mask
		draw_set_colour(WC_drag_alt ? c_aqua : c_red);
		draw_set_alpha(0.25);
		draw_rectangle(WC_drag_inst.bbox_left, WC_drag_inst.bbox_top, WC_drag_inst.bbox_right, WC_drag_inst.bbox_bottom, false);
		draw_set_alpha(1);
		
		with WC_drag_inst
		{
			x = xp;
			y = yp;
		}
	}
}

function scr_wc_drawgui()
{
	draw_set_font(consoleFont);
	
	// vars
	var mousex = device_mouse_x_to_gui(0), mousey = device_mouse_y_to_gui(0);
	var wincol = c_black, txtcol = c_white;

	// windows
	for(var i = 0; i < ds_list_size(WC_win_list); i++)
	{
		var win = WC_win_list[|i];
		with win
		{
			var focused = other.WC_win_focus == self;
		
			// move window
			if focused && (mousey < win_y or win_moving) && !win_resize
			{
				if mouse_check_button(mb_left)
				{
					if !win_moving
					{
						WC_win_dragx = mousex - win_x;
						WC_win_dragy = mousey - win_y;
						win_moving = true;
					}
					win_x = mousex - WC_win_dragx;
					win_y = mousey - WC_win_dragy;
				}
				else
					win_moving = false;
				
				if mouse_check_button(mb_right) && win_moving
				{
					delete win;
					other.WC_win_focus = -1;
					ds_list_delete(other.WC_win_list, i);
					continue;
				}
			}
			else
				win_moving = false;
		
			// resize window
			if (mousex < win_x + win_width + 4 && mousex >= win_x + win_width - 4
			&& mousey < win_y + win_height + 4 && mousey >= win_y + win_height - 4 && !win_moving)
			or (win_resize && mouse_check_button(mb_left))
			{
				if win_resize or !other.WCscr_overconsole()
					window_set_cursor(cr_size_nwse);
				if focused && mouse_check_button(mb_left)
				{
					if !win_resize
					{
						WC_win_dragx = mousex - win_width;
						WC_win_dragy = mousey - win_height;
						win_resize = true;
					}
					win_width = max(mousex - WC_win_dragx, 16);
					win_height = max(mousey - WC_win_dragy, 16);
				}
				else
					win_resize = false;
			}
			else
				win_resize = false;
		
			// draw
			if !surface_exists(win_surf)
				win_surf = surface_create(1, 1);
			else
			{
				// window content
				surface_resize(win_surf, win_width, win_height);
			
				surface_set_target(win_surf);
				draw_clear_alpha(wincol, 0.35);
				draw_set_colour(txtcol);
				draw();
				surface_reset_target();
			
				draw_surface(win_surf, win_x, win_y);
			
				// window top
				draw_set_colour(wincol);
				draw_set_alpha(focused ? 0.6 : 0.45);
				draw_rectangle(win_x, win_y, win_x + win_width - 1, win_y - 32, false);
			
				draw_set_colour(txtcol);
				draw_text(win_x + 6, win_y - 33 + floor(string_height("M") / 2), win_title);
			
				draw_set_alpha(1);
			}
		}
	}
	
	// dragging
	if instance_exists(WC_drag_inst)
	{
		draw_set_color(WC_drag_alt ? merge_colour(c_aqua, c_white, 0.75) : c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		
		var dragtext = "Dragging ";
		if mouse_check_button(mb_middle) && keyboard_check(vk_control)
			dragtext = "Duplicating ";
		var postext = "x" + string(WC_drag_inst.x) + " y" + string(WC_drag_inst.y);
		if WC_drag_alt
			postext += "  >  x" + string(floor((mouse_x - other.WC_drag_offset[0]) / other.WC_drag_grid[0]) * other.WC_drag_grid[0]) + " y" + string(floor((mouse_y - other.WC_drag_offset[1]) / other.WC_drag_grid[1]) * other.WC_drag_grid[1]);
		draw_text_outline(display_get_gui_width() / 2, 0, dragtext + object_get_name(WC_drag_inst.object_index) + "\n" + postext);
	}
}

