//Draw Text
draw_set_halign(fa_center);
draw_set_color(c_white)
draw_self()

// start drawing
if place_meeting(x, y, obj_player1) && !drawing
{
	drawing = true
	obj_tv.manualhide = manualhide
}

// stop drawing
if (!place_meeting(x, y, obj_player1) or obj_player1.state == states.victory) && drawing
{
	obj_camera.panto = [0, 0];
	
	drawing = false
	obj_tv.manualhide = false
}

// actually draw
if drawing
{
	// read savefile before drawing
	if !readsave
	{
		ini_open("saveData" + string(global.saveslot) + ".ini");
		
		tamin = ini_read_real("TAmin", string(level), -1);
		tasec = ini_read_real("TAsec", string(level), -1);
		tadec = ini_read_real("TAdec", string(level), 0);
		tachar = ini_read_string("TAchar", string(level), "?");
		
		toppin1 = ini_read_real("Toppin", string(level) + "1", 0);
		toppin2 = ini_read_real("Toppin", string(level) + "2", 0);
		toppin3 = ini_read_real("Toppin", string(level) + "3", 0);
		toppin4 = ini_read_real("Toppin", string(level) + "4", 0);
		toppin5 = ini_read_real("Toppin", string(level) + "5", 0);
		
		secret = ini_read_string("Secret", string(level), 0);
		highscore = ini_read_real("Highscore", string(level), 0);
		
		ini_close();
		readsave = true;
	}
	
	// time attack time
	if tamin >= 0 && global.timeattack
	{
		draw_set_colour(c_yellow);
		draw_set_font(global.font_small);
		
		var middle = ":";
		if tasec < 10
			middle = ":0";
		
		var precisertext = ".";
		if tadec < 10
			precisertext = ".0";
		draw_text(x, y - 60, string(tamin) + middle + string(tasec) + precisertext + string(tadec) + " (" + tachar + ")");
	}
	
	// setup
	draw_set_font(global.bigfont)
	draw_set_colour(c_white);
	
	// secret count
	var outof = 6;
	if level == "etb"
		outof = 2;
	if level == "mansion"
		outof = 3;
	
	if check_sugary()
		outof = 3;
	
	// where the score number should be displayed
	var scory = -90;
	
	// TOPPINS (and secret)
	if level != "snickchallenge" && level != "snickrematch" && level != "eatery" && level != "dragonlair" && level != "golf" && level != ""
	{
		scory = -160; // raise score number to fit these
		
		// draw secrets
		if level != "freezer" && level != "sewer" && level != "factory"
		&& global.gameplay == 0
		{
			if sprite_index == spr_entrancegate && obj_player1.state == states.normal
				obj_camera.panto = [0, -32];
			draw_text_auto(x, y - 200, string(secret) + " of " + string(outof) + " Secrets");
		}
		
		// sugary spire toppins
		var sugary = false;
		if level == "cotton" or level == "mines" or level == "entryway" or level == "molasses"
			sugary = true;
		
		// toppins
		var toppin1spr = spr_toppinshroom;
		var toppin2spr = spr_toppincheese;
		var toppin3spr = spr_toppintomato;
		var toppin4spr = spr_toppinsausage;
		var toppin5spr = spr_toppinpineapple;
		var sep = 75;
		
		if level == "strongcold"
		{
			if global.gameplay == 0
			{
				toppin1spr = spr_xmasshroomtoppin_idle;
				toppin2spr = spr_xmascheesetoppin_idle;
				toppin3spr = spr_xmastomatotoppin_idle;
				toppin4spr = spr_xmassausagetoppin_idle;
				toppin5spr = spr_xmaspineappletoppin_idle;
			}
			else
			{
				toppin1spr = spr_xmastoppinshroom_NEW;
				toppin2spr = spr_xmastoppincheese_NEW;
				toppin3spr = spr_xmastoppintomato_NEW;
				toppin4spr = spr_xmastoppinsausage_NEW;
				toppin5spr = spr_xmastoppinpineapple_NEW;
			}
		}
		else if sugary
		{
			if global.gameplay == 0
			{
				toppin1spr = spr_toppinmallow;
				toppin2spr = spr_toppinchoco;
				toppin3spr = spr_toppincrack;
				toppin4spr = spr_toppinworm;
				toppin5spr = spr_toppinworm_run;
			}
			else
			{
				sep = 100;
				toppin1spr = spr_toppinmallow_taunt_NEW;
				toppin2spr = spr_toppinchoco_taunt_NEW;
				toppin3spr = spr_toppincrack_taunt_NEW;
				toppin4spr = spr_toppinworm_taunt_NEW;
				toppin5spr = spr_toppincandy_taunt_NEW;
			}
		}
		else if global.gameplay != 0
		{
			toppin1spr = spr_toppinshroom_NEW;
			toppin2spr = spr_toppincheese_NEW;
			toppin3spr = spr_toppintomato_NEW;
			toppin4spr = spr_toppinsausage_NEW;
			toppin5spr = spr_toppinpineapple_NEW;
		}
		
		draw_sprite_ext(toppin1spr, 0, x - sep, y - 120, 1, 1, 0, toppin1 ? c_white : c_black, 1);
		draw_sprite_ext(toppin2spr, 0, x - sep / 2, y - 120, 1, 1, 0, toppin2 ? c_white : c_black, 1);
		draw_sprite_ext(toppin3spr, 0, x, y - 120, 1, 1, 0, toppin3 ? c_white : c_black, 1);
		draw_sprite_ext(toppin4spr, 0, x + sep / 2, y - 120, 1, 1, 0, toppin4 ? c_white : c_black, 1);
		draw_sprite_ext(toppin5spr, 0, x + sep, y - 120, 1, 1, 0, toppin5 ? c_white : c_black, 1);
	}
	
	// draw the score
	if level != "eatery" && level != ""
		draw_text(x, y + scory, string(highscore))
	
	ini_close();
}

