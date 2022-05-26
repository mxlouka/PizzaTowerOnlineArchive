if instance_exists(obj_player)
{
	x = obj_player.x;
	y = obj_player.y;
	
	frameone = true;
}

panto = [0, 0];
pancur = [0, 0];

shake_mag = 0;
shake_mag_acc = 0;

zoom = 1;
angle = 0;
limitcam = [0, 0, room_width, room_height];
camera_set_view_size(view_camera[0], 960, 540);
camera_set_view_angle(view_camera[0], 0);

targetoverride = noone
targetgoingback = false

// get all background layers in the room
ds_list_clear(global.roombgs);
var l = layer_get_all();
for (var i = 0; i < array_length(l); i++;)
{
	var lbg = layer_background_get_id(l[i]);
	if lbg != -1
	{
		ds_list_add(global.roombgs, {
			lay : l[i],
			bg : lbg,
			x : layer_get_x(l[i]),
			y : layer_get_y(l[i]),
			hsp : layer_get_hspeed(l[i]),
			vsp : layer_get_vspeed(l[i]),
		});
	}
}

//DDP Set the panic shader on the backgrounds
if !check_shaders()
	global.panicbg = false;
if (global.panic or global.snickchallenge) && global.panicbg
	scr_panicbg_init();

//DDP Disable any kind of motion blur
application_surface_draw_enable(true)

