// Transformation prompts
if room != Realtitlescreen && global.gameplay != 0
{
	if !ds_exists(special_prompts, ds_type_map)
	or special_prompts == noone
	{
	    special_prompts = ds_map_create();
	
	    ini_open("saveData" + global.saveslot + ".ini");
	    ds_map_set(special_prompts, "knight", ini_read_real("Prompts", "knight", 0));
	    ds_map_set(special_prompts, "boxxedpep", ini_read_real("Prompts", "boxxedpep", 0));
	    ds_map_set(special_prompts, "mort", ini_read_real("Prompts", "mort", 0));
	    ds_map_set(special_prompts, "squished", ini_read_real("Prompts", "squished", 0));
	    ds_map_set(special_prompts, "skateboard", ini_read_real("Prompts", "skateboard", 0));
	    ds_map_set(special_prompts, "cheeseball", ini_read_real("Prompts", "cheeseball", 0));
	    ds_map_set(special_prompts, "shotgun", ini_read_real("Prompts", "shotgun", 0));
	    ds_map_set(special_prompts, "ghost", ini_read_real("Prompts", "ghost", 0));
	    ds_map_set(special_prompts, "firemouth", ini_read_real("Prompts", "firemouth", 0));
	    ds_map_set(special_prompts, "fireass", ini_read_real("Prompts", "fireass", 0));
	    ds_map_set(special_prompts, "bombpep", ini_read_real("Prompts", "bombpep", 0));
	    ds_map_set(special_prompts, "rocket", ini_read_real("Prompts", "rocket", 0));
	    ini_close();
		
		// once one of the transformation texts are shown, change save file to never show them again
	}
}
else
{
	if ds_exists(special_prompts, ds_type_map)
		ds_map_destroy(special_prompts);
	special_prompts = noone;
}

// tv visibility
if room == rank_room or room == timesuproom or room == boss_room1 or room == Oldtitlescreen or room == characterselect or room == editor_entrance
or (instance_exists(obj_gms) && global.__chat)
{
	visible = false;
	if global.gameplay != 0
	{
	    animset = spr_tv_off;
	    tvsprite = spr_tv_idle;
		state = states.transitioncutscene;
	}
}
else
	visible = true;

// check if sugary tv
with obj_player
	other.sugary = (character == "SP" or character == "SN");

// text
panicy = 600 + (string_height(message) - 16);
if showtext
{
	xi = (960 / 2) + random_range(1, -1);
	if yi > 500 + 32
		yi -= 5
	else
		yi = 500 + 32
}
else
{
	xi = (960 / 2) + random_range(1,-1)
	if yi < panicy
		yi += 1
	else
		yi = panicy
}

#region old hud

if global.gameplay == 0
{
	// if recently switched from new gameplay to old.
	if surface_exists(promptsurface)
	{
		surface_free(promptsurface);
		image_index = 0;
		image_speed = 0.1;
		tvsprite = spr_tvdefault;
		sprite_index = tvsprite;
	}
	
	// make transparent for player
	if (instance_exists(obj_player) && obj_player.y < _camy + 200 && obj_player.x > _camx + _camw - 200)
	or manualhide
		alpha = 0.5
	else if !(room == rank_room or room == timesuproom or room == boss_room1 or room == Realtitlescreen or room == characterselect)
		alpha = 1

	// FUCKING RUN
	if instance_exists(obj_itspizzatime)
	{
		image_speed = 0.25
		message = "GET TO THE EXIT!!"
		alarm[0] = 200
		showtext = true
		tvsprite = spr_tvexit
	}
	
	// Rank milestone
	else if global.srank > 0 && (!instance_exists(obj_player) or obj_player.character != "S")
	&& ((global.collect >= global.srank && !shownranks)
	or (global.collect >= global.arank && !shownranka)
	or (global.collect >= global.brank && !shownrankb)
	or (global.collect >= global.crank && !shownrankc))
	{
		image_speed = 0.1
		showtext = true
		alarm[0] = 200
		
		// i was gonna use applemunch's code and credit it but "switch true" isn't a thing lol
		if !shownrankc
		{
			message = "YOU GOT ENOUGH FOR RANK C!";
			tvsprite = spr_tvrankc;
			shownrankc = true;
		}
		else if !shownrankb
		{
			message = "YOU GOT ENOUGH FOR RANK B!";
			tvsprite = spr_tvrankb;
			shownrankb = true;
		}
		else if !shownranka
		{
			message = "YOU GOT ENOUGH FOR RANK A!";
			tvsprite = spr_tvranka;
			shownranka = true;
		}
		else if !shownranks
		{
			message = "YOU GOT ENOUGH FOR RANK S!!!";
			tvsprite = spr_tvranks;
			shownranks = true;
		}
	}
	
	// good job you don't in fact suck
	else if instance_exists(obj_player) && obj_player.sprite_index == spr_player_levelcomplete
	{
		image_speed = 0.1
		alarm[0] = 50
		chose = true
		tvsprite = spr_tvclap
		once = true
	}
	
	// owie moans in pain uwu
	else if instance_exists(obj_player) && obj_player.state == states.hurt 
	{
		if !chose
			message = choose("OW!", "OUCH!", "OH!", "WOH!")
		chose = true
		
		image_speed = 0.1
		showtext = true
		alarm[0] = 50
		tvsprite = spr_tvhurt
		once = true
	}
	
	// skull emoji face ass
	else if instance_exists(obj_player)
	&& (obj_player.state == states.timesup or obj_player.state == states.ejected)
	{
		alarm[0] = 50
		image_speed = 0.1
		tvsprite = spr_tvskull
	}
	
	// miniboss
	else if global.miniboss
	{
		alarm[0] = 50
		image_speed = 0.1
		tvsprite = spr_tvnoise
	}
	
	// milestone for sucking dick
	else if global.hurtcounter >= global.hurtmilestone
	{
		alarm[0] = 150
		image_speed = 0.1
		
		var char = "";
		if instance_exists(obj_player)
			char = obj_player.character;
		
		switch char
		{
			case "P": character = "PEPPINO"; break;
			case "N": character = "THE NOISE"; break;
			case "S": character = "SNICK"; break;
			case "V": character = "VIGILANTE"; break;
			case "SP": character = "PIZZELLE"; break;
			case "SN": character = "PIZZANO"; break;
			case "M": character = "PEPPERMAN"; break;
			case "PP": character = "PISSINO"; break;
			case "CT": character = "CHEEMSTOON"; break;
			case "PUFFER": character = "PUFFERFISH"; break;
			
			default: character = "UNKNOWN"; break;
		}
		
		message = "YOU HAVE HURT " + string(character) + " " + string(global.hurtmilestone) + " TIMES...";
		if tvsprite != spr_tvtalking1 && tvsprite != spr_tvtalking2 && tvsprite != spr_tvtalking3 && tvsprite != spr_tvtalking4
			tvsprite = choose(spr_tvtalking1, spr_tvtalking2, spr_tvtalking3, spr_tvtalking4);
		global.hurtmilestone += 10;
	}
	
	// Skateboard
	else if instance_exists(obj_player) && obj_player.state == states.skateboard
	{
		showtext = true
		message = "SWEET DUDE!!"
		alarm[0] = 50
		tvsprite = spr_tvrad
		once = true
	}
	
	// combo
	else if global.combo != 0 && global.combotime != 0
	&& (tvsprite == spr_tvdefault or tvsprite == spr_tvcombo or tvsprite == spr_tvescape)
	{
		tvsprite = spr_tvcombo
		imageindexstore = global.combo - 1;
	}
	
	// good job combo
	else if global.combotime <= 0 && tvsprite == spr_tvcombo
	{
		tvsprite = spr_tvcomboresult;
		if !sugary
		{
			image_speed = 0;
			image_index = min(imageindexstore, 3);
		}
		alarm[0] = 50
	}
	
	// potassium showcase
	else if room == Realtitlescreen
	{
		image_speed = 0.1
		tvsprite = spr_tvbanana
	}
	
	if instance_exists(obj_player) && obj_player.state == states.keyget
	{
		showtext = true
		message = "GOT THE KEY!"
		if check_sugary()
			message = "KEY OBTAINED!"
		alarm[0] = 50
	}
	
	if instance_exists(obj_noise_pushbutton)
	{ 
		if obj_noise_pushbutton.hsp != 0 && !global.panic
		{
			showtext = true
			message = "UH OH..."
			alarm[0] = 50
		}
	}
	
	if sprite_index != tvsprite
	{
		tvimg = 0;
		sprite_index = tvsprite;
	}
}

#endregion
#region new hud

else
{
	alpha = 1;
	
	image_speed = 0.35;
	if bubblespr != noone && bubblespr != spr_tv_bubbleclosed
	{
	    if prompt != noone
	        prompt_buffer = 2;
	    bubbleindex += image_speed;
	    if floor(bubbleindex) == sprite_get_number(bubblespr)
	    {
	        bubbleindex = 0;
	        switch bubblespr
	        {
	            case spr_tv_bubbleopen:
	                bubblespr = spr_tv_bubble;
	                break;
	            case spr_tv_bubbleclose:
	                bubblespr = spr_tv_bubbleclosed;
	                if prompt == noone or prompt == ""
	                    bubblespr = noone;
	                break;
	        }
	    }
	}
	
	var pchar = "";
	var _state = states.normal;
	if instance_exists(obj_player)
	{
		pchar = obj_player.character;
		_state = obj_player.state;
		
		if _state == states.hitlag
			_state = obj_player.tauntstoredstate;
		if _state == states.backbreaker
		{
			with obj_teleporter
			{
				if alarm[0] > -1 or alarm[1] > -1
					_state = storedstate;
			}
			with obj_warplaser
			{
				if alarm[0] > -1 or alarm[1] > -1
					_state = storedstate;
			}
		}
	}
	
	switch state
	{
	    case states.normal:
			if animset != spr_tv_open
	        {
		        idlespr = spr_tv_idle;
			
				if pchar != "P" && pchar != "N" && pchar != "SP" && pchar != "SN" && pchar != "PP" && pchar != "S" && pchar != "CT"
					idlespr = spr_tv_placeholder;
				else
				{
			        switch _state
			        {
						default:
							with obj_player
			                {
			                    if shotgunAnim
			                        other.idlespr = spr_tv_shotgun;
			                    else if global.mort
			                        other.idlespr = spr_tv_mort;
								else if skateboarding
									other.idlespr = spr_tv_clown;
			                }
			                break;
						
			            case states.knightpep:
			            case states.knightpepslopes:
			            case states.knightpepattack:
			                idlespr = spr_tv_knight;
			                break;
						
			            case states.bombpep:
			                idlespr = spr_tv_bombpep;
			                break;
			
			            case states.fireass:
			                idlespr = spr_tv_fireass;
							with obj_player
							{
								if (sprite_index == spr_scaredjump1
								or sprite_index == spr_scaredjump2
								or sprite_index == spr_scaredjump3)
								&& spr_scaredjump2 != spr_fireass
									other.idlespr = spr_tv_scaredjump;
							}
			                break;
			
			            case states.tumble:
			                idlespr = spr_tv_tumble;
			                break;
			
			            case states.firemouth:
			                idlespr = spr_tv_firemouth;
			                break;
			
			            case states.ghost:
			                idlespr = spr_tv_ghost;
			                break;
			
			            case states.stunned:
							with obj_player
							{
								if sprite_index == spr_squished
									other.idlespr = spr_tv_squished;
							}
			                break;
			
			            case states.barrel:
			                idlespr = spr_tv_barrel;
			                break;
			
			            case states.golf:
			                idlespr = spr_tv_golf;
			                break;
						
			            case states.rocket:
			                idlespr = spr_tv_rocket;
			                break;
						
			            case states.cheeseball:
			                idlespr = spr_tv_cheeseball;
			                break;
						
			            case states.cotton:
			                idlespr = spr_tv_cotton;
			                break;
						
			            case states.cheesepep:
			            case states.cheesepepstick:
			            case states.cheesepepstickside:
			            case states.cheesepepstickup:
			                idlespr = spr_tv_cheesepep
			                break
						
			            case states.boxxedpep:
			                idlespr = spr_tv_boxxedpep
			                break
			        }
				}
				
		        switch animset
		        {
		            case spr_tv_off:
		                if visible
		                {
		                    animset = spr_tv_open;
		                    image_index = 0;
		                }
		                break;
			
		            case spr_tv_open:
		                if floor(image_index) == image_number - 1
		                    animset = idlespr;
		                break
				
					case spr_tv_placeholder:
						if idlespr != spr_tv_placeholder
							animset = idlespr;
						break;
					
		            case spr_tv_idle:
		                if idleanim > 0
		                    idleanim--;
		                if animset != idlespr
		                    animset = idlespr;
				
		                if idleanim <= 0 && floor(image_index) == image_number - 1
		                {
		                    animset = choose(spr_tv_idleanim1, spr_tv_idleanim2);
		                    image_index = 0;
		                }
		                break
				
		            case spr_tv_idleanim1:
		            case spr_tv_idleanim2:
		                if floor(image_index) == image_number - 1
		                {
		                    animset = idlespr;
		                    idleanim = 240 + 60 * irandom_range(-1, 2);
		                }
		                if idlespr != spr_tv_idle
		                    animset = idlespr;
		                break;
					
		            default:
						if ds_list_empty(tvprompts_list)
						or (tvsprite == spr_tv_idleanim1 or tvsprite == spr_tv_idleanim2)
							animset = idlespr;
						break;
		        }
				
	            if !ds_list_empty(tvprompts_list)
	            {
					if (bubblespr == spr_tv_bubbleclosed or bubblespr == noone)
					&& prompt_buffer <= 0
					{
		                var b = tvprompts_list[| 0];
		                prompt_buffer = prompt_max;
						
		                if b[0] != "" && b[0] != noone
		                {
		                    bubblespr = spr_tv_bubbleopen;
		                    bubbleindex = 0;
		                    prompt = b[0];
		                    promptspd = b[3];
		                    promptx = promptxstart;
		                }
		                else
		                {
		                    if bubblespr != noone && bubblespr != spr_tv_bubbleclosed
		                        bubblespr = spr_tv_bubbleclose
		                    if bubblespr == spr_tv_bubbleclosed
		                        bubblespr = noone;
						
		                    bubbleindex = 0;
		                    promptx = promptxstart;
		                    prompt = noone;
		                }
					
						tvsprite = b[2];
						
						if b[1] == false
						{
							animset = spr_tv_open;
							image_index = 0;
						}
					}
					
					if animset != spr_tv_open
					{
						if tvsprite != spr_tv_idleanim1 && tvsprite != spr_tv_idleanim2
							animset = tvsprite;
						
						if prompt_buffer > 0
						{
				            prompt_buffer--;
				            if prompt_buffer <= 0
				            {
				                promptx = promptxstart;
				                ds_list_delete(tvprompts_list, 0);
				                // state = states.normal;
				            }
						}
					}
	            }
	            else
	                bubblespr = noone;
	        }
			else if floor(image_index) >= image_number - 1
				animset = tvsprite;
			
			// sugary spire panic tvs
			if sugary && global.panic
			{
				if panic_anim <= 0
					panic_timer--
				if panic_timer <= 0
				{
					panic_sprite = choose(spr_tv_escape1SP, spr_tv_escape2SP, spr_tv_escape3SP, spr_tv_escape4SP, spr_tv_escape5SP, spr_tv_escape6SP, spr_tv_escape7SP);
					panic_anim = room_speed * 5
					panic_timer = room_speed * random_range(5, 10)
				}
			}
			
			// sugary spire exclusive tv sprites
			if sugary && panic_anim > 0
			{
				panic_anim--;
				sprite_index = panic_sprite;
				idlespr = sprite_index;
			}
			else if pchar == "SP" && happy_timer > 0
			{
				happy_timer--;
				sprite_index = spr_tv_happySP;
				idlespr = sprite_index;
			}
			else if pchar == "SP" && obj_player.angry
			{
				sprite_index = spr_tv_angrySP;
				idlespr = sprite_index;
			}
			else if pchar == "SP" && global.combo >= 3 && global.combotime > 0
			{
				sprite_index = spr_tv_menacingSP;
				idlespr = sprite_index;
			}
			else if pchar == "SP" && (_state == states.mach1 or _state == states.handstandjump or _state == states.crouchslide)
				sprite_index = spr_tv_mach1SP;
			else if pchar == "SP" && (_state == states.mach2 or _state == states.machslide)
				sprite_index = spr_tv_mach2SP;
			else if pchar == "SP" && (_state == states.mach3 or _state == states.machroll)
			{
				sprite_index = spr_tv_mach3SP;
				if obj_player.sprite_index == obj_player.spr_crazyrun
					sprite_index = spr_tv_mach4SP;
			}
			else if pchar == "SP" && _state == states.hurt
			{
				sprite_index = spr_tv_hurtSP;
				idlespr = sprite_index;
			}
			
			// set tv sprite to the corresponding character
			else if tvsprite != spr_tv_open && animset != spr_tv_open
			{
				if instance_exists(obj_player) && obj_player.character != "P"
				{
				    var spr = sprite_get_name(animset);
				    spr = asset_get_index(spr + string_upper(string(obj_player.character)));
					
				    if sprite_exists(spr)
				        sprite_index = spr;
					else
					{
						if sugary
						{
							animset = spr_tv_placeholderSP;
							sprite_index = spr_tv_placeholderSP;
						}
						else if pchar == "PP"
						{
							animset = spr_tv_placeholderPP;
							sprite_index = spr_tv_placeholderPP;
						}
						else if pchar == "CT"
						{
							animset = spr_tv_placeholderCT;
							sprite_index = spr_tv_placeholderCT;
						}
						else
						{
							animset = spr_tv_placeholder;
							sprite_index = spr_tv_placeholder;
						}
					}
				}
				else
					sprite_index = animset;
			}
			else
			{
				if sugary
					sprite_index = spr_tv_openSP;
				else if pchar == "PP"
					sprite_index = spr_tv_openPP;
				else
					sprite_index = spr_tv_open;
			}
			
			if pchar == "PUFFER"
			{
				idlespr = spr_tv_idlePUFFER;
				sprite_index = idlespr;
				idleanim = 240;
			}
	        break;
		
	    case states.transitioncutscene:
			if animset == spr_tv_off
				animset = spr_tv_open;
	        if animset == spr_tv_open && floor(image_index) == image_number - 1
	            animset = tvsprite;
			
			var spr = sprite_get_name(animset);
			spr = asset_get_index(spr + string_upper(string(obj_player.character)));
					
			if sprite_exists(spr)
				sprite_index = spr;
			else
				sprite_index = animset;
			
			if animset == tvsprite
				state = states.normal;
	        break;
	}
	
	// hide tv if player overlapping it
	var change_pos = false;
	
	with obj_player
	{
		if point_in_rectangle(x, y, _camx + _camw - 224, _camy, _camx + _camw, _camy + 187)
			change_pos = true;
		if other.bubblespr != noone && point_in_rectangle(x, y, _camx + _camw - 644, _camy, _camx + _camw, _camy + 101)
			change_pos = true;
	}
	if manualhide
		change_pos = true;
	if instance_exists(obj_fadeout)
		change_pos = false;
	
	var spd = 15;
	if change_pos
	    hud_posY = Approach(hud_posY, -300, spd);
	else
	    hud_posY = Approach(hud_posY, 0, spd);
}

#endregion