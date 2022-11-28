extends Node

func get_value_by_percent(value, percent):
	return float(value) / 100 * float(percent)

func get_modified_value_by_percent(value, percent):
	return float(value) + float(value) / 100 * float(percent)
