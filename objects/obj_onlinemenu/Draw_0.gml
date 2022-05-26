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

function draw_textfield(x, y, w = 254, h = 30, maximum = 32)
{
	// setup the textbox
	var x2 = x + w, y2 = y + h;
	
	var varprefix = "textfield" + string(x * y);
	var struct = ds_map_find_value(textboxes, varprefix);
	if struct == undefined
	{
		struct = {
			str : "",
			sel : false,
			textline : 0,
			scroll : 0
		}
	}
	
	// draw the text and the textbox itself
	var subwaysurfers = surface_create(w, h);
	surface_set_target(subwaysurfers);
	
	draw_set_font(font0);
	draw_set_halign(fa_left);
	draw_clear(c_white);
	draw_set_colour(c_black);
	draw_rectangle(1, 1, w - 2, h - 2, true);
	
	var xx = 0, yy = 0, scrollw = (h < 60 ? struct.scroll : 0), scrollh = (h >= 60 ? struct.scroll : 0);
	for(var i = 1; i <= string_length(struct.str); i++)
	{
		var char = string_char_at(struct.str, i);
		if xx + scrollw >= 0 && xx + scrollw <= w && yy + scrollh >= 0 && yy + scrollh <= h
			draw_text(xx + 6 + scrollw, yy + 6 + scrollh, char);
		
		xx += string_width(char);
		if xx >= w - 16 && h >= 60
		{
			xx = 0;
			yy += 16;
		}
	}
	if floor(struct.textline / 20)
		draw_text(xx + scrollw, yy + 6 + scrollh, " |");
	
	// scrolling
	var hover = mouse_x >= x && mouse_y >= y && mouse_x < x2 && mouse_y < y2;
	if hover
	{
		if mouse_wheel_down()
			struct.scroll -= 16;
		if mouse_wheel_up()
			struct.scroll += 16;
	}
	
	// selected
	if !struct.sel
	{
		if mouse_check_button_pressed(mb_left) && hover
		{
			cooldown = 2;
			
			struct.textline = 20;
			struct.sel = true;
			keyboard_string = struct.str;
		}
	}
	if struct.sel
	{
		if cooldown <= 0
		{
			if struct.str != keyboard_string
			{
				keyboard_string = string_copy(keyboard_string, 1, maximum);
				
				xx -= string_width(struct.str) - string_width(keyboard_string);
				struct.scroll = -xx;
				struct.str = keyboard_string;
			}
		}
		else
			cooldown--;
		struct.textline = (struct.textline + 1) % 40;
		
		if mouse_check_button_pressed(mb_left) && !hover
		{
			struct.textline = 0;
			struct.sel = false;
		}
	}
	
	surface_reset_target();
	draw_surface(subwaysurfers, x, y);
	surface_free(subwaysurfers);
	
	struct.scroll = clamp(struct.scroll, -max((h >= 60 ? yy - h + 32 : xx - w + 16), 0), 0);
	
	ds_map_set(textboxes, varprefix, struct);
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
				var desc = ds_map_find_value(level, "description");
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
						level_desc = desc;
						level_author = author;
						
						level_string = undefined;
						
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
				if debug && string_startswith(searchstring, "id:") && string_digits(searchstring) != ""
				{
					records = undefined;
					menu = menutypes.leveldetails;
					level_id = real(string_digits(searchstring));
					level_name = undefined;
					level_desc = undefined;
					level_author = undefined;
					level_string = undefined;
						
					scr_requestlevel_alt(level_id, global.auth);
				}
				else
				{
					page = 1;
					records = undefined;
					paging_type = 4;
					searchstring_real = searchstring;
					scr_requestpage_alt(page);
				}
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
		if paging_type == 3 && !loading
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
		draw_rectangle(320 - 75, 0, 640 + 75, 540, false);
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
			if draw_editorbutton(384, debug ? 296 : 360, lang_string("editor.menu.level.play")) && viewpos == 0
			{
				if string_contains(level_category, "GAMEPLAY_")
				{
					gameplay_chosen = string_copy(level_category, string_pos("GAMEPLAY_", level_category) + 9, 1);
					if (gameplay_chosen == 0 && global.gameplay != 0)
					or (gameplay_chosen == 1 && global.gameplay == 0)
						menu = menutypes.warngameplay;
				}
				else
				{
					scr_playerreset();
					with obj_player
						targetDoor = "A";
					room_goto(custom_lvl_room);
				}
			}
			
			// delete level
			if global.auth != "" && (level_userid == userid or debug)
			{
				if draw_editorbutton(32, 540 - 72, lang_string("editor.menu.level.delete"))
				{
					deletion_confirm++;
					if deletion_confirm == 2
					{
						showtext = false;
						deletion_confirm = 0;
						scr_soundeffect(sfx_breakblock2);
						scr_requestleveldelete(level_id);
					}
					else
					{
						message = lang_string("editor.menu.level.deleteconfirm");
						showtext = true;
					}
				}
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
		
		if draw_editorbutton(32, 32, lang_string("editor.menu.back")) && viewpos == 0 && request == ""
		{
			level_string = undefined;
			menu = menutypes.levelbrowser;
			request = "";
			
			if alarm[0] == -1
				showtext = false;
			
			if records == undefined
				scr_requestpage_alt(page);
		}
		
		#endregion
		break;
	#endregion
	#region login / register
	case menutypes.login:
		var lg_name = "testuser";
		if check_online()
			lg_name = string_copy(gms_self_name(), 1, 32);
		
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320, 0, 640, 540, false);
		draw_set_alpha(1);
		
		#endregion
		#region back
		
		show_debug_message(passwordstring);
		if draw_editorbutton(32, 32, lang_string("editor.menu.back")) && viewpos == 0
		{
			if registering
			{
				selectedpassword = false;
				registering = false;
				passwordstring = passconfirm1;
			}
			else
			{
				menu = loginback == -1 ? menutypes.levelbrowser : loginback;
				request = "";
				
				if records == undefined && loginback == -1
					scr_requestpage_alt(page);
				loginback = -1;
			}
		}
		
		#endregion
		
		draw_set_font(global.bigfont);
		draw_set_halign(fa_center);
		draw_text_auto(960 / 2, 96, lang_string("editor.menu.search.login")); // level name
		
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
					// go to confirm password
					selectedpassword = false;
					passconfirm1 = passwordstring;
					passwordstring = "";
					keyboard_string = "";
					registering = true;
				}
			}
			
			#endregion
		}
		else
		{
			#region confirm password
			
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
					selectedpassword = false;
					scr_requestregister_alt(lg_name, md5_string_utf8(passconfirm1));
				}
			}
			
			#endregion
		}
		
		#region authed
		
		if global.auth != ""
		{
			menu = loginback == -1 ? menutypes.levelbrowser : loginback;
			request = "";
			records = undefined;
			
			message = lang_string("editor.menu.login.success");
			showtext = true;
			alarm[0] = room_speed * 2;
			
			if loginback == -1
				scr_requestpage_alt(page);
			loginback = -1;
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
			request = "";
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
		draw_text_auto(_camw - 16, 16, lang_string("editor.menu.upload.loadfile"));
		
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
						{
							fileopen = get_open_filename_ext(lang_string("editor.menu.filefilter"), "", "%localappdata%\\PizzaTower_GM2\\Levels\\", lang_string("editor.menu.loadtitle"));
							level_name = string_copy(fileopen, string_last_pos("\\", fileopen), string_length(fileopen));
						}
						else
						{
							fileopen = "Levels/" + ll;
							level_name = ll;
						}
						
						if file_exists(fileopen)
						{
							var _buffer = buffer_load(fileopen);
							if _buffer == -1
								show_message(lang_string("editor.menu.upload.fail"));
							else
							{
								level_string = buffer_read(_buffer, buffer_string);
								buffer_delete(_buffer);
								
								menu = menutypes.choosegameplay;
								gameplay_chosen = -1;
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
				draw_text(xx, yy + 4, ll == -1 ? lang_string("editor.menu.upload.choosefile") : ll);
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
		#region back
		if draw_editorbutton(32, 32, lang_string("editor.menu.cancel"))
		{
			menu = menutypes.listfiles;
			request = "";
		}
		#endregion
		
		if !loading
		{
			var tt = "Level title", dd = "Level description";
			var leveltitle = draw_textfield(352, 100);
			var leveldesc = draw_textfield(352, 200,, 200, 180);
			
			tt += " (" + string(string_length(leveltitle)) + "/32)";
			dd += " (" + string(string_length(leveldesc)) + "/180)";
			
			draw_set_font(global.font_small);
			draw_set_colour(c_white);
		
			draw_text(352, 100 - 20, tt);
			draw_text(352, 200 - 20, dd);
			
			if draw_editorbutton(384, 450, lang_string("editor.menu.search.upload")) && !loading
			{
				if string_replace_all(leveltitle, " ", "") == ""
				{
					message = lang_string("editor.menu.upload.titleempty");
					alarm[0] = 100;
					showtext = true;
				}
				else
				{
					level_name = leveltitle;
					level_desc = leveldesc;
				
					level_category = "";
					if gameplay_chosen != 2 && gameplay_chosen > -1
						level_category += "GAMEPLAY_" + string(gameplay_chosen);
				
					scr_requestlevelupload(leveltitle, leveldesc, level_string, level_category);
					loading = true;
				}
			}
		}
		break;
	
	#endregion
	#region choose gameplay style
	
	case menutypes.choosegameplay:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320 - 75, 0, 640 + 75, 540, false);
		draw_set_alpha(1);
		
		#endregion
		if draw_editorbutton(32, 32, lang_string("editor.menu.back"))
		{
			menu = menutypes.listfiles;
			level_string = undefined;
		}
		
		draw_set_font(global.smallfont);
		draw_set_halign(fa_center);
		draw_text_auto(960 / 2, 64, level_name);
		
		draw_set_font(global.font_small);
		draw_text(960 / 2, 128, lang_string("editor.menu.gameplay"));
		
		if draw_editorbutton(384, 260, lang_string("options.other.gameplay.old"))
			gameplay_chosen = 0;
		if draw_editorbutton(384, 260 + 64, lang_string("options.other.gameplay.final"))
			gameplay_chosen = 1;
		
		var any = draw_editorbutton(384, 260 + 64 + 64, lang_string("editor.menu.gameplay.any"));
		if any == 1
			gameplay_chosen = 2;
		if any == -1
		{
			draw_set_font(global.font_small);
			draw_set_halign(fa_center);
			draw_text_auto(mouse_x, mouse_y - 26, lang_string("editor.menu.gameplay.anywarn"));
		}
		
		// chosen
		if gameplay_chosen != -1
		{
			global.gameplay = gameplay_chosen == 0 ? 0 : 1;
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
		break;
	
	#endregion
	#region warn about gameplay style
	
	case menutypes.warngameplay:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320 - 75, 0, 640 + 75, 540, false);
		draw_set_alpha(1);
		
		#endregion
		if draw_editorbutton(32, 32, lang_string("editor.menu.back"))
			menu = menutypes.leveldetails;
		
		draw_set_colour(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		if level_name != undefined
		{
			draw_set_font(global.bigfont);
			draw_text_auto(960 / 2, 128, string_upper(string(level_name))); // level name
		}
		
		draw_set_valign(fa_top);
		draw_set_font(global.font_small);
		draw_text(960 / 2, 192, lang_string("editor.menu.gameplay.warn1") + (gameplay_chosen == 0 ? lang_string("options.other.gameplay.old") : lang_string("options.other.gameplay.final")) + lang_string("editor.menu.gameplay.warn2"));
		
		if draw_editorbutton(384, 320, lang_string("editor.menu.gameplay.switch"))
		{
			global.gameplay = gameplay_chosen;
			gameplay_chosen = -1;
		}
		if draw_editorbutton(384, 320 + 64, lang_string("editor.menu.gameplay.ignore"))
			gameplay_chosen = -1;
		
		if gameplay_chosen == -1
		{
			scr_playerreset();
			with obj_player
				targetDoor = "A";
			room_goto(custom_lvl_room);
		}
		break;
	
	#endregion
	#region vote level
	
	case menutypes.vote:
		#region black box
		
		draw_set_colour(c_black);
		draw_set_alpha(0.25);
		draw_rectangle(320 - 75, 0, 640 + 75, 540, false);
		draw_set_alpha(1);
		
		#endregion
		
		draw_set_colour(c_white);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		if level_name != undefined
		{
			draw_set_font(global.bigfont);
			draw_text_auto(960 / 2, 128, string_upper(string(level_name))); // level name
		}
		
		if global.auth != ""
		{
			if draw_editorbutton(32, 32, lang_string("editor.menu.cancel"))
				menu = menutypes.leveldetails;
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_font(global.font_small);
			draw_text(960 / 2, 192, lang_string("editor.menu.wannarate"));
			
			if !loading && obj_editor_cursor.sprite_index == spr_editor_cursor
			{
				if draw_editorbutton(384, 296, lang_string("editor.menu.level.like"))
				{
					scr_requestlevelrate(level_id, 1);
					obj_editor_cursor.sprite_index = spr_editor_cursorlike;
					obj_editor_cursor.image_index = 0;
				}
				if draw_editorbutton(384, 296 + 64, lang_string("editor.menu.level.dislike"))
				{
					scr_requestlevelrate(level_id, 2);
					obj_editor_cursor.sprite_index = spr_editor_cursordislike;
					obj_editor_cursor.image_index = 0;
				}
			}
		}
		else
		{
			draw_set_halign(fa_center);
			draw_set_valign(fa_top);
			draw_set_font(global.font_small);
			draw_text(960 / 2, 192, lang_string("editor.menu.logintorate"));
			
			if draw_editorbutton(384, 296, lang_string("editor.menu.search.login"))
			{
				loginback = menu;
				menu = menutypes.login;
			}
			if draw_editorbutton(384, 296 + 64, lang_string("editor.menu.cancel"))
				menu = menutypes.leveldetails;
		}
		break;
	
	#endregion
}

if loading
{
	draw_sprite_ext(spr_loading, 0, room_width / 2, room_height / 2, 1, 1, loadingrotation, c_white, 1);
	loadingrotation += 1 + abs(sin(current_time / 400) * 2);
}

