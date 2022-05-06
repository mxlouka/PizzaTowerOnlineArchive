/// @description increase pizzacoin
var increase = floor(global.collect / 2000)
if increase > 0
{
	scr_soundeffect(sfx_pizzacoin)
	global.pizzacoin += increase
}

