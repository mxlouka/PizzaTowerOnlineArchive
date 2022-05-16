//DDP Raise this value to change how intense the blur is
if live_call() return live_result;
application_surface_draw_enable(false);

#macro MAX_BLUR 2 / 3
var appa = 1;
if global.panic && global.panicmelt
	appa = max(lerp(1.0, 1.0 - MAX_BLUR, global.wave / global.maxwave), 0.01);

var shader = noone;
if global.panic && global.minutes <= 0 && global.seconds <= 0 && check_sugary()
	shader = shd_greyscale;
else if !instance_exists(obj_endlevelfade)
	shaderfade = 0;

if shader != noone
{
	shaderfade = Approach(shaderfade, 0.45, 0.005);
	
    shader_set(shader)
    var fade = shader_get_uniform(shader, "fade")
    shader_set_uniform_f(fade, shaderfade)
}
draw_surface_stretched_ext(application_surface, 0, 0, 960, 540, c_white, appa);
if shader != noone
	shader_reset();

