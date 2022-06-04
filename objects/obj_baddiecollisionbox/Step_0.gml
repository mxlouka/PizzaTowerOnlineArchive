var bad = baddieID;
if !instance_exists(bad) or bad.ghost
{
	instance_destroy();
	exit;
}

x = bad.x;
y = bad.y;
image_xscale = bad.image_xscale;

with obj_baddiecollisionbox
{
	if id != other.id && baddieID == bad
		instance_destroy();
}

var player = instance_place(x, y, obj_player);
if player && !player.cutscene && (player.state != states.firemouth or global.gameplay != 0) && player.state != states.gameover && player.state != states.hitlag
&& baddieID.state != states.grabbed && baddieID.state != states.hit
{
	with player
	{
		//Insta kill
		if bad.invtime <= 0 && instakillmove && (!bad.thrown or global.gameplay != 0) && !bad.invincible && bad.instantkillable
		{
			suplexmove = false
			if state == states.mach3 && sprite_index != spr_mach3hit && (character = "P" or character = "V" or (character == "N" && noisetype == 1))
			{
				if !fightball
					sprite_index = spr_mach3hit
				image_index = 0
			}
			if state == states.mach2 && grounded && sprite_index != spr_rollgetup
			{
				machpunchAnim = true
				image_index = 0
			}
			if state == states.chainsawbump && sprite_index != spr_player_chainsawhit
			{
				image_index = 0
				sprite_index = spr_player_chainsawhit
			}
			if bad.object_index != obj_tankOLD && !bad.killprotection
			{
				if state == states.mach3 or state == states.rocket or state == states.tumble
				or (state == states.freefall && freefallsmash > 10) or state == states.superslam
				or state == states.chainsawbump or state == states.punch or state == states.firemouth
				or state == states.knightpep or state == states.knightpepslopes or state == states.grab
				or state == states.rideweenie
				{
					bad.hp -= 99;
					bad.instakilled = true;
				}
			}
			if state != states.hurt
				bad.grabbedby = 1;
			
			global.hit += 1;
			if !grounded && state != states.freefall && key_jump2
			{
				if state == states.mach2 or (state == states.mach3 && !fightball)
					sprite_index = spr_mach2jump
				suplexmove = false
				vsp = -11
			}
			
			var lag = 5;
			
			if (sprite_index == spr_attackdash or sprite_index == spr_airattack or sprite_index == spr_airattackstart)
			&& character == "P"
			{
				lag = 12;
				if sprite_index == spr_attackdash
					sprite_index = spr_player_groundedattack
				else
					sprite_index = spr_player_ungroundedattack
				image_index = random_range(0, image_number)
			}
			if state == states.chainsawbump
			{
				bad.hp -= 99
				sprite_index = spr_player_chainsawhit
				image_index = 0
			}
			
			if global.gameplay == 0
				instance_destroy(bad);
			else
			{
				bad.image_xscale = -xscale;
				bad.hithsp = 0;
				
				if key_up
				{
					bad.hitvsp = -11;
					bad.thrown_vertically = true;
				}
				else if key_down
					bad.hitvsp = 11;
				else
				{
					bad.hithsp = -8 * bad.image_xscale;
					bad.hitvsp = -8;
				}
				scr_hitthrow(bad, id, lag);
				bad.invtime = 25;
			}
			
			scr_soundeffect(sfx_punch);
			scr_failmod(mods.pacifist);
			exit;
		}
		
		//Attack
		else if instance_exists(bad) && (state == states.handstandjump && sprite_index != spr_attackdash && sprite_index != spr_airattackstart && sprite_index != spr_airattack) && !bad.invincible && character != "S"
		{
			if (!bad.thrown or global.gameplay != 0) && !(character == "SP" && shotgunAnim && !key_slap) // && (character = "P" or character = "N" or character == "SP" or bad.object_index == obj_pizzaballOLD)
			{
				movespeed = 0
				image_index = 0
				sprite_index = spr_haulingstart
				
				state = states.grab
				if character == "SP"
					scr_soundeffect(sfx_grabenemy_ss)
				
				bad.state = states.grabbed
				bad.grabbedby = 1
				
				baddiegrabbedID = bad
			}
			else
			{
				increase_combo();
					
				if bad.thrown == true && !key_up 
				{
					bad.hsp = xscale * 25
					bad.vsp = 0
				}
				else if !key_up
				{
					bad.hsp = xscale * 6
					bad.vsp = -6
				}
				else
				{
					bad.vsp = -14
					bad.hsp = 0
				}
					
				if bad.object_index == obj_pizzaballOLD
					global.golfhit += 1;
				scr_soundeffect(sfx_killingblow)
				
				movespeed = 0;
				scr_pummel(character == "SP");
					
				scr_throwenemy(bad);
			}
		}
			
		//Stomp
		else if instance_exists(bad) && y < bad.y && !attacking && sprite_index != spr_player_mach2jump && sprite_index != spr_swingding && ((state == states.boots && vsp > 0) or state == states.jump or state == states.mach1 or state == states.grab) && vsp > 0 && bad.vsp >= 0 && sprite_index != spr_stompprep && (sprite_index != spr_swingding or global.gameplay == 0) && !bad.invincible && bad.stompable
		{
			scr_soundeffect(sfx_stompenemy)
			if bad.object_index != obj_tank && (bad.object_index != obj_bigcheese or global.gameplay == 0)
			{
				if x != bad.x
					bad.image_xscale = -sign(bad.x - x)
				
				if bad.object_index == obj_pizzaballOLD
					global.golfhit += 1
				
				if global.gameplay != 0
				{
					bad.hsp = xscale * 5
					bad.vsp = -5
				}
				else
				{
					scr_soundeffect(sfx_bumpwall)
					if state != states.bombpep && state != states.mach1 && state != states.crouchslide && state != states.machroll && state != states.mach2 && state != states.mach3 && state != states.revolver && state != states.dynamite && state != states.climbwall && state != states.frozen && state != states.cotton
						movespeed = 0
					
					bad.stuntouchbuffer = 50
					
					bad.vsp = -5
					bad.hsp = -bad.image_xscale * 2
					bad.image_index = 0
				}
				
				bad.image_index = 0
				bad.state = states.stun
				if bad.stunned < 100
					bad.stunned = 100
			}
			if scr_stylecheck(2)
				bad.yscale = 0.35;
			
			instance_create(x, y + 50, obj_stompeffect)
			stompAnim = true
			
			if key_jump2
				vsp = -14
			else
				vsp = -9
				
			if state == states.jump
				sprite_index = spr_stompprep
		}
			
		//Pogo
		else if place_meeting(x, y + 1, other) && state == states.pogo && vsp > 0 && bad.vsp >= 0 && sprite_index != spr_playerN_pogobounce && sprite_index != spr_playerSP_canebounce && !bad.invincible
		{
			if !pogochargeactive or bad.object_index == obj_pizzaballOLD
			{
				pogospeedprev = false
				scr_soundeffect(sfx_stompenemy)
				
				bad.state = states.stun
				bad.vsp = -3
				bad.stunned = max(bad.stunned, 100)
				if scr_stylecheck(2)
					bad.yscale = 0.35;
				
				sprite_index = spr_playerN_pogobounce
				if character == "SP"
					sprite_index = spr_playerSP_canebounce
			}
			else if !bad.thrown
			{
				pogospeedprev = false
				scr_throwenemy()
				if global.gameplay != 0
					increase_combo();
				sprite_index = spr_playerN_pogobouncemach
			}
			
			instance_create(x, y + 50, obj_stompeffect)
			image_index = 0
			movespeed = 0
			vsp = 0
		}
			
		// Cotton
		else if state == states.cotton && (sprite_index == spr_cotton_attack or sprite_index == spr_cotton_roll or sprite_index == spr_cotton_rollmax or movespeed > 6) && bad.instantkillable && !bad.thrown
		{
			scr_soundeffect(sfx_punch);
			if sprite_index == spr_cotton_drill
			{
				if bad.vsp < 8
					bad.vsp = 8;
				bad.hsp = 0;
			}
			else
			{
				if bad.vsp > -12
					bad.vsp = -12; 
				bad.hsp = xscale * 15;
			}
			if sprite_index == spr_cotton_attack
				bad.cottoncoated = true;
			
			with bad
			{
				if global.gameplay == 0
				{
					hp = 0;
					scr_throwenemy(id);
				}
				else
				{
					if hp > 0
						hp = 0;
					image_xscale = -other.xscale;
					hithsp = hsp;
					hitvsp = vsp;
					scr_hitthrow(id, other, 8);
				}
			}
		}
		
		//Stun from touching
		else if !bad.thrown && bad.stuntouchbuffer == 0 && bad.state != states.pizzagoblinthrow && bad.vsp > 0 && state != states.punch && state != states.tackle && state != states.superslam && state != states.pogo && state != states.machslide  && state != states.freefall && (state != states.mach2 or bad.object_index == obj_pizzaballOLD) && state != states.handstandjump && state != states.hurt && bad.state != states.chase
		&& bad.bumpable && !bad.invincible 
		&& ((bad.object_index != obj_pizzice && bad.object_index != obj_ninja) or bad.state != states.charge)
		{
			if bad.object_index != obj_tank
			{
				scr_soundeffect(sfx_bumpwall)
				
				if state != states.bombpep && state != states.mach1 && state != states.crouchslide && state != states.machroll && state != states.mach2 && state != states.mach3 && state != states.revolver && state != states.dynamite && state != states.climbwall && state != states.frozen && state != states.cotton
					movespeed = 0
				
				bad.stuntouchbuffer = 50
				
				if bad.object_index = obj_pizzaballOLD
					global.golfhit += 1
				if bad.stunned < 100
					bad.stunned = 100
				
				if x != bad.x
					bad.image_xscale = -sign(bad.x - x)
				bad.vsp = -5
				bad.hsp = -bad.image_xscale * 2
				bad.state = states.stun
				bad.image_index = 0
			}
			else
			{
				bad.stuntouchbuffer = 10;
				if y == bad.y && state != states.stunned && grounded && !hurted && (bad.state == states.walk or bad.state == states.pizzagoblinthrow) && bad.image_xscale == -sign(bad.x - x)
				{
					state = states.stunned
					sprite_index = spr_squished
					image_index = 0
				}
			}
		}
	}
}