extends Node

func get_value_by_percent(value, percent):
	return value / 100 * percent


func get_modified_value_by_percent(value, percent):
	return value + value / 100 * percent
