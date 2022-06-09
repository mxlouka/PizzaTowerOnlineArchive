function layer_get_parallax(layer_id)
{
	var roomwidth = room_width, roomheight = room_height;
	var _camx2 = _camx, _camy2 = _camy;

	if instance_exists(obj_camera) && instance_exists(obj_player)
	&& obj_camera.bound_camera && instance_exists(obj_player.cam)
	{
		roomwidth = obj_player.cam_width;
		roomheight = obj_player.cam_width;
		_camx2 -= obj_player.cam.x;
		_camy2 -= obj_player.cam.y;
	}
	
	var n = layer_get_name(layer_id);
	switch n
	{
		case "Backgrounds_1": return [_camx * 0.25, _camy * 0.25]; break;
		case "Backgrounds_2": return [_camx * 0.15, _camy * 0.15]; break;
		case "Backgrounds_3": return [_camx * 0.05, _camy * 0.05]; break;
		
		case "Backgrounds_fore1": return [_camx * -0.1, _camy * -0.1]; break;
		case "Backgrounds_Ground1": return [_camx * 0.35, roomheight - _camh + ((roomheight - (_camy2 + _camh)) * -0.25)]; break;
		case "Backgrounds_Ground2": return [_camx * 0.25, roomheight - _camh + ((roomheight - (_camy2 + _camh)) * -0.35)]; break;
		case "Backgrounds_H1": return [_camx * 0.25, _camy]; break;
		
		case "Backgrounds_sky": return [_camx * 0.85, _camy * 0.85]; break;
		case "Backgrounds_sky2": return [_camx, _camy]; break;
		case "Backgrounds_sky3": return [_camx * 0.95, _camy * 0.95]; break;
		
		case "Backgrounds_scroll": return [_camx * 0.25, _camy * 0.25]; break;
		case "Backgrounds_FG": return [(layer_get_x(layer_id) - _camx) * 0.15, (layer_get_y(layer_id) - _camy) * 0.15]; break;
		
		case "Backgrounds_still1":
		case "Backgrounds_still2":
		case "Backgrounds_stillH1":
		case "Backgrounds_stillH2":
		case "Backgrounds_stillH3":
			var p = [0, 0], hor = true;
			switch n
			{
				case "Backgrounds_still1": p = [0.15, 0.15]; break;
				case "Backgrounds_still2": p = [0.25, 0.25]; break;
				case "Backgrounds_stillH1": p = [0.25, 0.15]; hor = false; break;
				case "Backgrounds_stillH2": p = [0.35, 0.15]; hor = false; break;
				case "Backgrounds_stillH3": p = [0.95, 0.15]; hor = false; break;
			}
			if hor
				var returnx = _camx - clamp(_camx2 * p[0] * (960 / roomwidth), 0, sprite_get_width(layer_background_get_sprite(layer_background_get_id(layer_id))) - 960);
			else
				returnx = _camx * p[0];
			
			return [returnx, _camy - clamp(_camy2 * p[1] * (540 / roomheight), 0, sprite_get_height(layer_background_get_sprite(layer_background_get_id(layer_id))) - 540)]; break;
		
		// pinpan moment
		case "Backgrounds_steamcc1": return [_camx * 0.95, _camy * 0.95]; break;
		case "Backgrounds_steamcc2": return [_camx * 0.75, _camy * 0.75]; break;
		case "Backgrounds_steamcc3": return [_camx * 0.25, (room_height - 560) + ((room_height - (_camy + _camh)) * 0.25)]; break;
		case "Backgrounds_steamcc5": return [_camx * 0.65, _camy * 0.65]; break;
	}
	return [0, 0];
}

var siz = ds_list_size(global.roombgs); // faster this way
for(var i = 0; i < siz; i++)
{
	var l = global.roombgs[|i];
	l.x += l.hsp;
	l.y += l.vsp;
	
	var parallax = layer_get_parallax(l.lay);
	if parallax == undefined
		parallax = [0, 0];
	
	layer_x(l.lay, floor(l.x + parallax[0]));
	layer_y(l.lay, floor(l.y + parallax[1]));
}

