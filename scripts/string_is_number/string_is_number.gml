function string_is_number(str) {
	return string_length(string_digits(str)) + string_count("-", str) + string_count(".", str) == string_length(str);
}

