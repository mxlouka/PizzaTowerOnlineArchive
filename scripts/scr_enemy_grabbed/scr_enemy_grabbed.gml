function scr_enemy_grabbed()
{
	var player = asset_get_index("obj_player" + string(grabbedby));
	if object_index == obj_treasureguy && global.gameplay == 0
	{
	    with player
	        scr_pummel();
	    instance_destroy()
	}
	
	if grabbedby == 1
	{
		image_xscale = -player.xscale
		stunned = 200					
		
		var _state = player.state;
		if _state == states.hitlag
			_state = player.tauntstoredstate;
		
		player.baddiegrabbedID = id
		
		if _state == states.grabbing or _state = states.grab or _state = states._throw or _state = states.slam or _state = states.tacklecharge or _state == states.backbreaker
		{
			scr_enemy_grabpos(player);
			visible = _state != states.backbreaker;
		}
		else
			visible = true;
		
		with (player)
		{
			suplexhavetomash = other.hp - 1
			//Suplex mash
			scr_getinput();

			move = key_left2 + key_right2;

			if key_slap && sprite_index == spr_grab
			{
				global.hit += 1
				if other.object_index = obj_pizzaballOLD
					global.golfhit += 1
				global.combotime = 60
				image_index = 0
				sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4)
				other.hp -= 1

				instance_create(other.x, other.y, obj_slapstar)
				instance_create(other.x, other.y, obj_baddiegibs)
				other.flash = true
				
				with (obj_camera)
				{
				    shake_mag=3;
				    shake_mag_acc=3/room_speed;
				}
			}
			
			if !((_state = states.grab) or  (_state = states.finishingblow) or (_state = states.grabbing) or (_state = states._throw) or (_state = states.slam) or (_state = states.tacklecharge) or (_state = states.punch) or (_state = states.superslam) or (_state = states.backkick) or (_state = states.uppunch) or (_state = states.shoulder) or (_state == states.backbreaker))
			{
				other.x = x 
				other.y = y 
				other.state = states.stun
				other.image_index = 0
			}
		}

		hsp = 0
		
		if _state = states.punch or _state == states.parry or _state == states.tackle
		{
			alarm[3] = 3
			global.hit += 1
			if object_index = obj_pizzaballOLD
				global.golfhit += 1
			
			hp -= 1
			instance_create(x + player.xscale * 30, y, obj_bumpeffect)
			alarm[1] = 5
			
			thrown = true
			x = player.x
			vsp = 0
			y = player.y
			
			state = states.stun
			hsp = -image_xscale * 25
			grav = 0
			
			increase_combo();
			repeat 3
			{
				instance_create(x,y,obj_slapstar)
				create_particle(x, y, particles.baddiegibs)
			}
			flash = true
			
			with (obj_camera) 
			{
			    shake_mag=3;
			    shake_mag_acc=3/room_speed;
			}
		}

		if _state = states.finishingblow && player.image_index < 5
		{
			x = player.x + (player.xscale * clipin);
			y = player.y
			player.baddiegrabbedID = id
			
			// clip in bounds
			with player
				if scr_solid(x + xscale, y)
				{
					other.clipin = 1;
					other.x = x;
				}
			while scr_solid(x, y) && clipin > 0
			{
				clipin--;
				x = player.x + (player.xscale * clipin);
			}
		}
		
		if _state = states.backkick 
		{
			alarm[3] = 3
			global.hit += 1
			if object_index = obj_pizzaballOLD
			global.golfhit += 1
			hp -= 1
			instance_create(x +(-player.xscale * 50), y, obj_bumpeffect)
			alarm[1] = 5

			thrown = true
			x = player.x
			y = player.y
			state = states.stun
			image_xscale *= -1
			hsp = -image_xscale * 20

			vsp = -7

			global.combotime = 60
			instance_create(x,y,obj_slapstar)
			instance_create(x,y,obj_baddiegibs)
			flash = true
			
		    with (obj_camera) {
			    shake_mag=3;
			    shake_mag_acc=3/room_speed;
			}

		}

		if _state = states.shoulder 
		{
			alarm[3] = 3
			global.hit += 1
			if object_index = obj_pizzaballOLD
			global.golfhit += 1
			hp -= 1
			instance_create(x , y+20, obj_bumpeffect)
			alarm[1] = 5

			thrown = true
			x =player.x
			y = player.y
			state = states.stun

			if player.sprite_index = spr_player_shoulder
				vsp = 15
			if player.sprite_index = spr_player_diagonaldownthrow
			{
				hsp  = -image_xscale  * 10
				vsp = 15
			}
			if player.sprite_index = spr_player_diagonalupthrow
			{
				hsp  = -image_xscale  * 10
				vsp = -15
			}

			global.combotime = 60
			instance_create(x,y,obj_slapstar)
			instance_create(x,y,obj_baddiegibs)
			flash = true
			
			with obj_camera
			{
			    shake_mag = 3;
			    shake_mag_acc = 3 / room_speed;
			}

		}
		
		if place_meeting(x, y, obj_swordhitbox)
		{
			if global.gameplay != 0 && object_index != obj_noisey && object_index != obj_tank
				hp -= 5
			
			repeat 3
			{
				instance_create(x, y, obj_slapstar)
				create_particle(x, y, particles.baddiegibs)
			}
			with obj_camera
			{
			    shake_mag = 3;
			    shake_mag_acc = 3 / room_speed;
			}
			
			if (scr_solid(x, y) && object_index == obj_pizzaballOLD)
			or place_meeting(x - (image_xscale * 32), y, obj_onewaybigblock)
			{
				x = player.x
				y = player.y
			}
			
			if place_meeting(x, y, obj_slope) && hp > 0 && object_index != obj_pizzaballOLD
				hp = -10;
			
			alarm[3] = 3
			global.hit += 1
			if object_index = obj_pizzaballOLD
				global.golfhit += 1
			global.combotime = 60
			alarm[1] = 5

			thrown = true
			state = states.stun
			with player
			{
				move = key_right + key_left
				if sprite_index == spr_uppercutfinishingblow
				{
					other.hsp = 0
					other.vsp = -25
					other.thrown_vertically = true
				}
				else
				{
					other.hsp = -other.image_xscale * 25
					other.vsp = -6
				}
			}
			
			if global.gameplay != 0
			{
				hithsp = hsp;
				hitvsp = vsp;
				
				scr_hitthrow(id, noone);
			}
			else
				hp -= 1
		}


		if _state = states._throw 
		{
			global.hit += 1
			if object_index = obj_pizzaballOLD
				global.golfhit += 1

			alarm[1] = 5

			thrown = true
			x =player.x
			y = player.y
			state = states.stun
			hsp = -image_xscale * 8
			vsp = -6
		}





		if _state = states.uppunch
		{
			alarm[3] = 3
			global.hit += 1
			if object_index = obj_pizzaballOLD
			global.golfhit += 1
			hp -= 1

			instance_create(x +(-player.xscale * 15), y-50, obj_bumpeffect)
			alarm[1] = 5

			thrown = true
			x =player.x
			y = player.y
			hsp = -image_xscale * 2
			state = states.stun
			vsp = -20

			global.combotime = 60
			instance_create(x,y,obj_slapstar)
			instance_create(x,y,obj_baddiegibs)
			flash = true
			
		    with obj_camera
			{
			    shake_mag=3;
			    shake_mag_acc=3/room_speed;
			}
		}


		//if player.state = states.backbreaker && floor(player.image_index) < 2
		//{
		//x = player.x + (-image_xscale *8)
		//y = player.y - 45
		//}

		//if player.state = states.backbreaker && floor(player.image_index) >= 2
		//{
		//x = player.x
		//y = player.y 
		//state = states.hit
		//hsp = -image_xscale * 5
		//vsp = -12
		//instance_create(x,y,obj_bangeffect)
		//}

		//Charge
		if _state == states.tacklecharge 
		{
			y = player.y
			
			if player.sprite_index == spr_playerSP_tackle
			{
				if floor(player.image_index) == 0
					x = player.x + (player.xscale * 30)
				if floor(player.image_index) == 1
					x = player.x + (player.xscale * 15)
				if floor(player.image_index) == 1
					x = player.x + (player.xscale * 18)
				if floor(player.image_index) == 3
					x = player.x + (player.xscale * 26)
				
				if player.image_index < 2
					depth = -8;
				else
					depth = 0;
			}
			else
				x = player.x + (player.xscale * 15)
		}

		if player.sprite_index = player.spr_piledriverland
		{
			if player.character == "SP"
				scr_enemy_driverpos(player);
			
			if floor(player.image_index) == player.image_number - 1
			{
				flash = true
				global.combotime = 60
				if object_index == obj_pizzaballOLD
					global.golfhit += 1
				else
					hp -= 5
			
				global.hit += 1
				alarm[1] = 5
				thrown = true
				x = player.x
				y = player.y
				state = states.stun
			
				hsp = -image_xscale * 10
				vsp = -10
			
				if global.gameplay != 0
				{
					hithsp = hsp;
					hitvsp = vsp;
				
					hp = -6;
					scr_hitthrow(id, noone);
				
					with player
					{
						jumpAnim = true;
				        state = states.jump;
				        sprite_index = spr_suplexland;
				        vsp = -11;
				        jumpstop = true;
				        image_index = 0;
					}
				}
				else
				{
					repeat 3
						instance_create(x,y,obj_slapstar)
					repeat 3
						create_particle(x, y, particles.baddiegibs)
				
					with player
					{
						state = states.jump
						vsp = -8
						sprite_index = spr_machfreefall
					}
				}
			}
		}
		
		if (_state == states.superslam
		&& player.sprite_index == player.spr_piledriver
		or player.sprite_index == spr_playerSP_piledriverstart) 
			scr_enemy_driverpos(player);
		
		else if (_state == states.grab
		&& player.sprite_index == player.spr_swingding)
		{
			if floor(player.image_index) = 0
			{
				depth = -8
				x = player.x + (player.xscale * 25)
				y = player.y
			}
			if floor(player.image_index) = 1
			{
				depth = -8
				x = player.x 
				y = player.y
			}
			if floor(player.image_index) = 2
			{
				depth = -8
				x = player.x + (player.xscale * -25)
				y = player.y
			}
			if floor(player.image_index) = 3
			{
				depth = 0
				x = player.x + (player.xscale * -50)
				y = player.y
			}
			if floor(player.image_index) = 4
			{
				depth = 0
				x = player.x + (player.xscale * -25)
				y = player.y
			}
			if floor(player.image_index) = 5
			{
				depth = 0
				x = player.x 
				y = player.y
			}
			if floor(player.image_index) = 6
			{
				depth = 0
				x = player.x + (player.xscale * 25)
				y = player.y
			}
			if floor(player.image_index) = 7
			{
				depth = 0
				x = player.x + (player.xscale * 50)
				y = player.y
			}
		}
		else if _state != states.tacklecharge
			depth = 0;
	}
	
	sprite_index = grabbedspr
	image_speed = 0.35
}