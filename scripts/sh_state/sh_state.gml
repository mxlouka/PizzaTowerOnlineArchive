function sh_state(args)
{
	if !instance_exists(obj_player)
		return "The player is not in the room";
	if array_length(args) < 2
		return "The current player state is " + obj_player.state;
	
	var _state = args[1];
	if string_is_number(_state)
	{
		with obj_player
			state = real(_state);
		return "Set the player's state to " + _state;
	}
	else
	{
		if string_startswith(_state, "states.")
			_state = string_replace(_state, "states.", "");
		
		if variable_global_exists("states") && is_struct(states) && variable_struct_exists(states, _state)
		{
			with obj_player
				state = variable_struct_get(states, _state);
			return "Set the player's state to " + args[1] + " (" + string(obj_player.state) + ")";
		}
		else
			return "The state " + args[1] + " does not exist";
	}
}
function meta_state()
{
	return {
		description: "change the player's state",
		arguments: ["state"],
		suggestions: [
			function()
			{
				var state_array = variable_struct_get_names(states);
				array_sort(state_array, true);
				return state_array;
			},
		],
	}
}

