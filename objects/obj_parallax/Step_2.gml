// loosely... "based off" the D3 mod
function layer_get_parallax(layer_id)
{
	var n = layer_get_name(layer_id);
	switch n
	{
		case "Backgrounds_1": return [_camx * 0.25, _camy * 0.25]; break;
		case "Backgrounds_2": return [_camx * 0.15, _camy * 0.15]; break;
		case "Backgrounds_3": return [_camx * 0.05, _camy * 0.05]; break;
		
		case "Backgrounds_fore1": return [_camx * -0.1, _camy * -0.1]; break;
		case "Backgrounds_Ground1": return [_camx * -0.25, _camy * -0.25]; break;
		case "Backgrounds_H1": return [_camx * 0.25, _camy]; break;
		
		// pinpan moment
		case "Backgrounds_steamcc1": return [_camx * 0.95, _camy * 0.95]; break;
		case "Backgrounds_steamcc2": return [_camx * 0.8, _camy * 0.8]; break;
		case "Backgrounds_steamcc3": return [_camx * -0.25, (room_height - 560) + ((room_height - (_camy + _camh)) * 0.25)]; break;
		case "Backgrounds_steamcc4": return [_camx * 0.4, (room_height - 540) + ((room_height - (_camy + _camh)) * -0.4)]; break;
		case "Backgrounds_steamcc5": return [_camx * 0.7, _camy * 0.7]; break;
		
		case "Backgrounds_sky": return [_camx * 0.85, _camy * 0.85]; break;
		case "Backgrounds_sky2": return [_camx, _camy]; break;
		case "Backgrounds_sky3": return [_camx * 0.95, _camy * 0.95]; break;
	}
	return [0, 0];
}

for(var i = 0; i < array_length(global.roombgs); i++)
{
	var l = global.roombgs[i];
	l.x += l.hsp;
	l.y += l.vsp;
	
	var parallax = layer_get_parallax(l.lay);
	if parallax == undefined
		parallax = [0, 0];
	
	layer_x(l.lay, l.x + parallax[0]);
	layer_y(l.lay, l.y + parallax[1]);
}

// legacy layers that i can't bother changing
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

if layer_exists("Backgrounds_still1")
{
	layer_x("Backgrounds_still1", _camx - clamp(_camx2 * 0.15 * (960 / roomwidth), 0, sprite_get_width(layer_background_get_sprite(layer_background_get_id(layer_get_id("Backgrounds_still1")))) - 960));
	layer_y("Backgrounds_still1", _camy - clamp(_camy2 * 0.15 * (540 / roomheight), 0, sprite_get_height(layer_background_get_sprite(layer_background_get_id(layer_get_id("Backgrounds_still1")))) - 540));
}
if layer_exists("Backgrounds_still2")
{
	layer_x("Backgrounds_still2", _camx - clamp(_camx2 * 0.25 * (960 / roomwidth), 0, sprite_get_width(layer_background_get_sprite(layer_background_get_id(layer_get_id("Backgrounds_still1")))) - 960));
	layer_y("Backgrounds_still2", _camy - clamp(_camy2 * 0.25 * (540 / roomheight), 0, sprite_get_height(layer_background_get_sprite(layer_background_get_id(layer_get_id("Backgrounds_still1")))) - 540));
}
if layer_exists("Backgrounds_stillH1")
{
	layer_x("Backgrounds_stillH1", _camx * 0.25);
	layer_y("Backgrounds_stillH1", _camy - clamp(_camy2 * 0.15 * (540 / roomheight), 0, sprite_get_height(layer_background_get_sprite(layer_background_get_id(layer_get_id("Backgrounds_stillH1")))) - 540));
}
if layer_exists("Backgrounds_stillH2")
{
	layer_x("Backgrounds_stillH2", _camx * 0.35);
	layer_y("Backgrounds_stillH2", _camy - clamp(_camy2 * 0.15 * (540 / roomheight), 0, sprite_get_height(layer_background_get_sprite(layer_background_get_id(layer_get_id("Backgrounds_stillH2")))) - 540));
}
if layer_exists("Backgrounds_stillH3")
{
	layer_x("Backgrounds_stillH3", _camx * 0.95);
	layer_y("Backgrounds_stillH3", _camy - clamp(_camy2 * 0.15 * (540 / roomheight), 0, sprite_get_height(layer_background_get_sprite(layer_background_get_id(layer_get_id("Backgrounds_stillH3")))) - 540));
}

