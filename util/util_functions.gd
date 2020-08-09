extends Node

func mantain_in_range_integer(lower_bound: int, upper_bound: int,
number: int) -> int:
	if number <= lower_bound:
		return lower_bound
	if number >= upper_bound:
		return upper_bound
	return number

func mantain_less_than_integer(upper_bound: int,
number: int) -> int:
	if number > upper_bound:
		return upper_bound
	return number

func mantain_in_range_float(lower_bound: float, upper_bound: float,
number: float) -> float:
	if number <= lower_bound:
		return lower_bound
	if number >= upper_bound:
		return upper_bound
	return number

func number_in_range_float(lower_bound: float, upper_bound: float,
number: float) -> bool:
	return lower_bound <= number and number <= upper_bound

func number_in_range_integer(lower_bound: int, upper_bound: int,
number: int) -> bool:
	return lower_bound <= number and number <= upper_bound
