if live_call() return live_result;

if debug
{
	if keyboard_check_pressed(vk_f4)
	{
		var g = get_integer("Menu number", menu);
		if g != undefined
			menu = g;
	}
}

function draw_textfield(x, y, w = 254, h = 30)
{
	var x2 = x + w, y2 = y + h;
	
	draw_set_colour(c_white);
	draw_rectangle(x, y, x2, y2, false);
	draw_set_colour(c_black);
	draw_rectangle(x, y, x2, y2, true);
	
	var varprefix = "textfield" + string(x * y), struct;
	if variable_instance_exists(id, varprefix)
		struct = variable_instance_get(id, varprefix);
	else
	{
		struct = {
			str : "",
			sel : false
		}
	}
		
	draw_set_font(font0);
	draw_set_halign(fa_left);
	
	if h >= 60
		draw_text_ext(x + 6, y + 6, struct.str + (struct.sel && textline ? "|" : ""), 20, w - 6);
	else
	{
		var xscale = 1;
		if string_width(struct.str) > w - 12
			xscale = (w - 12) / string_width(struct.str);
	
		draw_text_transformed(x + 6, y + 6, struct.str + (struct.sel && textline ? "|" : ""), xscale, 1, 0);
	}
	
	if struct.sel
	{
		if alarm[1] == -1
			alarm[1] = room_speed / 2;
		
		if keyboard_lastkey == vk_backspace
			struct.str = string_copy(struct.str, 1, string_length(struct.str) - 1);
		else
			struct.str += keyboard_lastchar;
		keyboard_lastchar = "";
		keyboard_lastkey = -1;
		
		if mouse_check_button_pressed(mb_left)
		&& !(mouse_x >= x && mouse_y >= y && mouse_x < x2 && mouse_y < y2)
		{
			alarm[1] = -1;
			textline = false;
			struct.sel = false;
		}
	}
	if !struct.sel
	{
		if mouse_check_button_pressed(mb_left)
		&& mouse_x >= x && mouse_y >= y && mouse_x < x2 && mouse_y < y2
		{
			textline = true;
			struct.sel = true;
		}
	}
	variable_instance_set(id, varprefix, struct);
	return struct.str;
}

draw_set_colour(c_white);
switch menu
{
	case menutypes.menustart:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320, 0, 640, 540, false);
		draw_set_alpha(1);
		
		#endregion
		#region starting menu
		
		if draw_editorbutton(384, 200 + (!debug * 64), lang_string("editor.menu.online"))
		{
			menu = menutypes.levelbrowser;
			paging_type = 3;
			scr_requestpage_alt(page);
			
			//menu = menutypes.menuonline;
		}
		
		if debug
		{
			if draw_editorbutton(384, 200 + 64, lang_string("editor.menu.load"))
			{
				window_set_cursor(cr_default);
				var fileopen = get_open_filename_ext(lang_string("editor.menu.filefilter"), "", "%localappdata%\\PizzaTower_GM2\\Levels\\", lang_string("editor.menu.loadtitle"));
				if fileopen != ""
				{
					window_set_cursor(cr_default);
					
					level_id = 1;
					
					var _buffer = buffer_load(fileopen);
					var _string = buffer_read(_buffer, buffer_string);
					buffer_delete(_buffer);
				
					level_string = _string;
					loading = false;
					
					scr_playerreset();
					room_goto(custom_lvl_room);
				}
				
				if instance_exists(obj_editor_cursor)
					window_set_cursor(cr_none);
			}
			
			if draw_editorbutton(384, 200 + 64 + 64, lang_string("editor.menu.build"))
			{
				/*
				window_set_cursor(cr_default);
				scr_playerreset();
				room = hub_outside2;
				obj_player1.targetDoor = "B";
				*/
				
				with obj_roomname
				{
					showtext = true;
					message = lang_string("editor.menu.wip");
					alarm[0] = 200;
				}
			}
		}
		
		if draw_editorbutton(384, 200 + 64 + 64 + (debug * 64), lang_string("editor.menu.back"))
		{
			scr_playerreset();
			room = hub_outside2;
			obj_player1.targetDoor = "B";
		}
		
		#endregion
		break;
	case menutypes.menuonline:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320, 0, 640, 540, false);
		draw_set_alpha(1);
		
		#endregion
		#region online menu
		
		if check_online() or debug
		{
			if draw_editorbutton(384, 200 + 64 + (debug * 64), lang_string("editor.menu.online.pto"))
			{
				menu = menutypes.levelbrowser;
				paging_type = 3;
				scr_requestpage_alt(page);
			}
		}
		
		if draw_editorbutton(384, 200 + 64 + 64 + (debug * 64), lang_string("editor.menu.back"))
			menu = menutypes.menustart;
		
		#endregion
		break;
	
	#region level browser
	case menutypes.levelbrowser:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(0, 0, 640, 540, false);
		draw_set_alpha(1);
		
		#endregion
		#region level browser
		
		if records != undefined
		{
			for(var i = 0; i < ds_list_size(records); i++)
			{
				var level = ds_list_find_value(records, i);
				var _id = ds_map_find_value(level, "id");
				
				var name = ds_map_find_value(level, "name");
				var upvotes = ds_map_find_value(level, "likes");
				var downvotes = ds_map_find_value(level, "dislikes");
				var author = ds_map_find_value(level, "author");
				//var userid = ds_map_find_value(level, "userid");
				
				draw_set_font(global.font_small);
				draw_set_colour(c_white);
				
				var yy = 38 + (i * 52) + yview;
			
				var sel = false;
	
				if mouse_x >= 56 && mouse_x <= 56 + 512
				&& mouse_y >= yy && mouse_y < yy + 52
				{
					sel = true;
		
					if mouse_check_button_pressed(mb_left) && sel != -1
					{
						records = undefined;
						menu = menutypes.leveldetails;
						level_id = _id;
						level_name = name;
						level_desc = ds_map_find_value(level, "description");
						level_author = author;
						
						level_string = undefined;
						
						if paging_type != 3
							scr_requestlevel(_id);
						else
							scr_requestlevel_alt(_id);
						break;
					}
				}
	
				draw_sprite(spr_editormenu_onlinelevel, sel, 56, yy);
			
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				draw_text(56 + 4, yy + 4, string(name));
			
				draw_set_valign(fa_bottom);
				draw_text(56 + 4, yy + 52 - 4, lang_string("editor.menu.search.preid") + string(_id) + lang_string("editor.menu.search.prelikes") + string(upvotes) + lang_string("editor.menu.search.predislikes") + string(downvotes));
				
				draw_set_halign(fa_right);
				draw_text(56 + 512 - 5, yy + 52 - 4, lang_string("editor.menu.search.preby") + string(author));
	
				//draw_set_valign(fa_top);
				//draw_text(56 + 512 - 5, yy + 4, lang_string("editor.menu.search.preuserid") + string(userid));
			
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
			}
		}
		
		// scrollbar
		if yviewmax <= -56
		{
			draw_sprite(spr_scrollbar, 0, 624, 25);
			draw_sprite(spr_scrollbar_button, scrolling, 624, 25 + ((yview / yviewmax) * 500));
		}
		
		// page show
		if pagelast != 0
		{
			draw_set_colour(c_white);
			
			draw_set_font(global.font_small);
			draw_set_colour(pagelast <= 1 ? c_ltgray : c_white);
			draw_set_halign(fa_right);
			draw_text(960 - 15, 16, lang_string("editor.menu.search.page1") + string(page) + lang_string("editor.menu.search.page2") + string(pagelast));
			draw_set_halign(fa_left);
			
			// page buttons
			if page != pagelast
			{
				if draw_editorbutton(704, 388, lang_string("editor.menu.search.pagnext")) && !loading
				{
					records = undefined;
					page++;
					scr_requestpage(page);
				}
			}
			
			if page > 1
			{
				if draw_editorbutton(704, 324, lang_string("editor.menu.search.pagprev")) && !loading
				{
					records = undefined;
					page--;
					scr_requestpage(page);
				}
			}
		}
		
		// search tool
		//if paging_type != 3
		{
			searchstring = draw_textfield(672, 42);
			
			// search button
			if searchstring != "" && (draw_editorbutton(704, 98 + 64, lang_string("editor.menu.search.search")) or (selectedsearch && keyboard_check_pressed(vk_enter)))
			{
				// search
				page = 1;
				records = undefined;
				paging_type = 4;
				searchstring_real = searchstring;
				scr_requestpage_alt(page);
			}
		}
		
		// go back
		if (draw_editorbutton(704, 458, lang_string("editor.menu.back")) or (paging_type == 2 && searchstring == "" && draw_editorbutton(704, 98, lang_string("editor.menu.back")))) && !loading
		{
			if paging_type != 4
			{
				records = undefined;
				menu = menutypes.menustart;
			}
			else
			{
				page = 1;
				searchstring = "";
				records = undefined;
				paging_type = 3;
				scr_requestpage_alt(page);
			}
		}
		
		// upload level
		if paging_type == 3 && !loading && debug
		{
			if draw_editorbutton(704, 98, global.auth == "" ? lang_string("editor.menu.search.login") : lang_string("editor.menu.search.upload"))
			{
				if global.auth == ""
				{
					menu = menutypes.login;
					searchstring = "";
				}
				else
				{
					menu = menutypes.listfiles;
					searchstring = "";
					loadlist = [];
				}
			}
		}
		
		#endregion
		break;
	#endregion
	#region level details
	case menutypes.leveldetails:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320, 0, 640, 540, false);
		if debug
			draw_rectangle(0, 540, 960, 540 * 2, false);
		draw_set_alpha(1);
		
		#endregion
		#region level details
		
		draw_set_colour(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		if level_name != undefined
		{
			draw_set_font(global.bigfont);
			draw_text_auto(960 / 2, 128, string_upper(string(level_name))); // level name
		}
		
		draw_set_font(global.font_small);
		if level_author != undefined
			draw_text(960 / 2, 192, lang_string("editor.menu.level.author") + string(level_author)); // by whoever
		if level_desc != undefined
			draw_text_ext(960 / 2, 256, string(level_desc), 18, 960 - 16); // description
		
		if level_string != undefined
		{
			// load level
			if draw_editorbutton(384, 296, lang_string("editor.menu.level.play")) && viewpos == 0
			{
				scr_playerreset();
				obj_player1.targetDoor = "A";
				room_goto(custom_lvl_room);
			}
			
			#region debug
			if debug
			{
				if draw_editorbutton(384, 360, lang_string("editor.menu.level.download")) && viewpos == 0
				{
					window_set_cursor(cr_default);
					var fileopen = get_save_filename_ext(lang_string("editor.menu.filefilter"), level_name + ".ptlv", "%localappdata%\\PizzaTower_GM2\\Levels\\", lang_string("editor.menu.savetitle"));
					if fileopen != ""
					{
						var filewrite = file_text_open_write(fileopen);
						file_text_write_string(filewrite, level_string);
						file_text_close(filewrite);
					
						showtext = true;
						message = lang_string("editor.menu.level.downloaded");
						alarm[0] = 200;
					}
					if instance_exists(obj_editor_cursor)
						window_set_cursor(cr_none);
				}
				
				if draw_editorbutton(384, 424, lang_string("editor.menu.level.debug")) && map != undefined
				{
					response = "";
					var first = ds_map_find_first(map);
					for (var i = 0; i < ds_map_size(map); i++)
					{
						response += "\n\"" + string(first) + "\": " + string_copy(string(map[?first]), 1, 200);
			
					    first = ds_map_find_next(map, first);
						if first == undefined
						{
							response += "\n";
							break;
						}
					}
					viewpos = 1;
				}
			}
			#endregion
		}
		
		if debug
		{
			if viewpos == 1
			{
				camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]), lerp(camera_get_view_y(view_camera[0]), 540, 0.25));
			
				if draw_editorbutton(32, 540 + 32, lang_string("editor.menu.back"))
				{
					alarm[0] = min(alarm[0], 1);
					viewpos = 0;
				}
			
				draw_set_colour(c_white);
				draw_set_font(global.font_small);
				draw_set_halign(fa_center);
				draw_set_valign(fa_top);
				draw_text(960 / 2, 540 + 32, lang_string("editor.menu.level.debugmap"));
			
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				draw_set_font(font0);
				draw_text(32, 540 + 32 + 48, response);
			
				if keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))
				{
					clipboard_set_text(string(asyncresult));
					showtext = true;
					message = lang_string("editor.menu.level.debugcopied");
					alarm[0] = room_speed * 2;
				}
			}
			if viewpos != 1
				camera_set_view_pos(view_camera[0], camera_get_view_x(view_camera[0]), lerp(camera_get_view_y(view_camera[0]), 0, 0.25));
		}
		
		if draw_editorbutton(32, 32, lang_string("editor.menu.back")) && viewpos == 0
		{
			level_string = undefined;
			menu = menutypes.levelbrowser;
			request = undefined;
			
			if records == undefined
				scr_requestpage_alt(page);
		}
		
		#endregion
		break;
	#endregion
	#region login / register
	case menutypes.login:
		var lg_name = "";
		if check_online()
			lg_name = string_copy(gms_self_name(), 1, 32);
		if debug
			lg_name = "admin";
		
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320, 0, 640, 540, false);
		draw_set_alpha(1);
		
		#endregion
		#region back
		
		if draw_editorbutton(32, 32, lang_string("editor.menu.back")) && viewpos == 0
		{
			if registering
			{
				selectedpassword = false;
				registering = false;
				passconfirm1 = "";
			}
			else
			{
				level_string = undefined;
				menu = menutypes.levelbrowser;
				request = undefined;
			
				if records == undefined
				{
					if paging_type != 3 // normal
						scr_requestpage(page);
					else // alt
						scr_requestpage_alt(page);
				}
			}
		}
		
		#endregion
		#region username
		
		draw_set_colour(c_black);
		draw_rectangle(352, 176, 608, 208, false);
		draw_set_colour(c_gray);
		draw_rectangle(352 + 1, 176 + 1, 608 - 1, 208 - 1, false);
		
		draw_set_font(font0);
		draw_set_colour(c_black);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_text(352 + 6, 176 + 6, lg_name);
		
		#endregion
		#region password
		
		draw_set_colour(c_black);
		draw_rectangle(352, 240, 608, 272, false);
		draw_set_colour(c_white);
		draw_rectangle(352 + 1, 240 + 1, 608 - 1, 272 - 1, false);
		
		draw_set_font(font0);
		draw_set_colour(c_black);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		var censoredstring = "";
		repeat string_length(passwordstring)
			censoredstring += "*";
		draw_text(352 + 6, 240 + 6, string(censoredstring) + (selectedpassword && textline ? "|" : ""));
		
		if !selectedpassword
		{
			textline = false;
			alarm[1] = -1;
			
			if mouse_check_button_pressed(mb_left)
			&& mouse_x >= 352 && mouse_y >= 240 && mouse_x < 608 && mouse_y < 272
			&& !loading
			{
				keyboard_string = string_lettersdigits(passwordstring);
				textline = true;
				selectedpassword = true;
			}
		}
		
		if selectedpassword && !loading
		{
			if alarm[1] == -1
				alarm[1] = room_speed / 2;
			
			keyboard_string = string_copy(string_lettersdigits(keyboard_string), 1, 30);
			passwordstring = keyboard_string;
				
			if mouse_check_button_pressed(mb_left)
			&& !(mouse_x >= 352 && mouse_y >= 240 && mouse_x < 608 && mouse_y < 272)
				selectedpassword = false;
		}
		
		draw_set_font(global.font_small);
		draw_set_colour(c_white);
		draw_text(352, 216, registering ? lang_string("editor.menu.login.reenter") : lang_string("editor.menu.login.password"));
		
		#endregion
		
		if !registering
		{
			#region logging in
		
			if (draw_editorbutton(384, 296, lang_string("editor.menu.login.login")) or (keyboard_check_pressed(vk_enter) && selectedpassword))
			&& !loading
			{
				if passwordstring == ""
				{
					message = lang_string("editor.menu.login.dumbfuck");
					showtext = true;
					alarm[0] = room_speed * 2;
				}
				else
				{
					selectedpassword = false;
					scr_requestlogin_alt(lg_name, md5_string_utf8(passwordstring));
				}
			}
		
			#endregion
			#region register
			
			if !regedit
			{
				if draw_editorbutton(384, 296 + 64, lang_string("editor.menu.login.register")) && !loading
				{
					if passwordstring == ""
					{
						message = lang_string("editor.menu.login.dumbfuck");
						showtext = true;
						alarm[0] = room_speed * 2;
					}
					else
					{
						selectedpassword = false;
						passconfirm1 = passwordstring;
						passwordstring = "";
						keyboard_string = "";
						registering = true;
					}
				}
			}
			
			#endregion
		}
		else
		{
			#region confirm password
			
			if regedit
			{
				registering = false;
				exit;
			}
			
			if draw_editorbutton(384, 296, lang_string("editor.menu.login.register")) && !loading
			{
				if passwordstring != passconfirm1
				{
					message = lang_string("editor.menu.login.dumbfuck2");
					showtext = true;
					alarm[0] = room_speed * 2;
				}
				else
				{
					passconfirm1 = "";
					selectedpassword = false;
					scr_requestregister_alt(lg_name, md5_string_utf8(passwordstring));
				}
			}
			
			#endregion
		}
		
		#region authed
		
		if global.auth != ""
		{
			level_string = undefined;
			menu = menutypes.levelbrowser;
			request = undefined;
			records = undefined;
			
			message = lang_string("editor.menu.login.success");
			showtext = true;
			alarm[0] = room_speed * 2;
			
			if paging_type != 3 // normal
				scr_requestpage(page);
			else // alt
				scr_requestpage_alt(page);
		}
		
		#endregion
		break;
	#endregion
	#region level file listing
	
	case menutypes.listfiles:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320, _camy - 64, 640, _camy + _camh + 32, false);
		draw_set_alpha(1);
		
		#endregion
		#region back
		if draw_editorbutton(32, 32, lang_string("editor.menu.back"))
		{
			menu = menutypes.levelbrowser;
			request = undefined;
			viewpos = 0;
			camera_set_view_pos(view_camera[0], 0, 0);
			
			if records == undefined
				scr_requestpage_alt(page);
			exit;
		}
		#endregion
		
		// title
		draw_set_font(global.smallfont);
		draw_set_halign(fa_right);
		draw_text_auto(_camw - 16, 16, "Select A Level!");
		
		// get file list
		if array_length(loadlist) == 0
		{
			loadlist = [-1];
			
			var filename = file_find_first("Levels/*.ptlv", 0);
			while filename != ""
			{
				array_push(loadlist, filename);
				filename = file_find_next();
			}
			file_find_close();
		}
		else
		{
			// list levels
			draw_set_halign(fa_center);
			draw_set_font(global.font_small);
			
			for(var i = 0; i < array_length(loadlist); i++)
			{
				var xx = 960 / 2, yy = 32 + i * 32;
				if yy < _camy - 24
					continue;
				if yy > _camy + _camh
					break;
				var ll = loadlist[i];
				
				// hover
				var x1 = xx - 128, y1 = yy, x2 = xx + 128, y2 = yy + 24;
				var dmx = device_mouse_x(0), dmy = device_mouse_y(0);
				
				var hovering = false;
				if point_in_rectangle(dmx, dmy, x1, y1, x2, y2)
				{
					hovering = true;
					if mouse_check_button_pressed(mb_left)
					{
						// test level
						var fileopen = "";
						if ll == -1
							fileopen = get_open_filename_ext(lang_string("editor.menu.filefilter"), "", "%localappdata%\\PizzaTower_GM2\\Levels\\", lang_string("editor.menu.loadtitle"));
						else
							fileopen = "Levels/" + ll;
						
						if file_exists(fileopen)
						{
							var _buffer = buffer_load(fileopen);
							if _buffer == -1
								show_message("Could not load file");
							else
							{
								level_string = buffer_read(_buffer, buffer_string);
								buffer_delete(_buffer);
								
								window_set_cursor(cr_default);
							
								level_id = 0;
								gmsroom = global.lastroom + irandom_range(1, 1000);
								loading = false;
								records = undefined;
								
								with obj_player
								{
									character = "P";
									paletteselect = 1;
									scr_characterspr();
								}
								scr_playerreset();
								room_goto(custom_lvl_room);
							}
						}
					}
				}
				
				// the rectangle
				draw_set_colour(c_white);
				draw_rectangle(x1, y1, x2, y2, false);
				draw_set_colour(hovering ? c_dkgray : c_black);
				draw_rectangle(x1 + 1, y1 + 1, x2 - 1, y2 - 1, false);
				
				draw_set_colour(c_white);
				draw_text(xx, yy + 4, ll == -1 ? "Choose file..." : ll);
			}
			
			if array_length(loadlist) > 14
			{
				if mouse_wheel_up()
					viewpos -= 64;
				if mouse_wheel_down()
					viewpos += 64;
				viewpos = clamp(viewpos, 0, (array_length(loadlist) - 15) * 32);
			}
			else
				viewpos = 0;
			
			camera_set_view_pos(view_camera[0], 0, lerp(_camy, viewpos, 0.25));
		}
		break;
	
	#endregion
	#region upload level
	
	case menutypes.upload:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320, 0, 640, 540, false);
		draw_set_alpha(1);
		
		#endregion
		
		draw_set_font(global.font_small);
		draw_set_colour(c_white);
		draw_text(352, 100 - 20, "Level title");
		draw_text(352, 200 - 20, "Level description");
		
		if !loading
		{
			var leveltitle = draw_textfield(352, 100);
			var leveldesc = draw_textfield(352, 200,, 200);
		}
		if draw_editorbutton(382, 450, lang_string("editor.menu.search.upload")) && !loading
		{
			level_name = leveltitle;
			level_desc = leveldesc;
			scr_requestlevelupload(leveltitle, leveldesc, level_string);
			loading = true;
		}
		break;
	
	#endregion
}

if loading
{
	draw_sprite_ext(spr_loading, 0, room_width / 2, room_height / 2, 1, 1, loadingrotation, c_white, 1);
	loadingrotation += 1 + abs(sin(current_time / 400) * 2);
}

