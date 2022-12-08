/// @description Initialize Discord.
if instance_number(object_index) > 1
{
	instance_destroy();
	exit;
}
global.discord_initialized = false;

if !global.richpresence
{
	instance_destroy();
	exit;
}

#macro DISCORD_APP_ID "828220751810265098"
if !np_initdiscord(DISCORD_APP_ID, true, np_steam_app_id_empty)
	show_error("NekoPresence init fail.", true);
