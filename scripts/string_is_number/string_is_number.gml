function string_is_number(str)
{
	if str == ""
		return false;
	return string_length(string_digits(str)) + string_count("-", str) + string_count(".", str) == string_length(str);
}

