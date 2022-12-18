extends Node

class_name Base_passive

signal apply_buff
signal destroy_buff
signal upgrade

var price = 1
var lvl = 0
var max_lvl = 1
var is_max_lvl = false

func _enter_tree():
	yield(get_tree(), "idle_frame")
	var owner_body = get_parent().get_parent()
	emit_signal("apply_buff", owner_body)

func _exit_tree():
	var owner_body = get_parent().get_parent()
	emit_signal("destroy_buff", owner_body)

func upgrade(new_lvl = lvl + 1):
	emit_signal("upgrade",  new_lvl)
	if max_lvl == lvl:
		is_max_lvl = true
#	emit_signal("destroy_buff", owner_body)
#	emit_signal("apply_buff", owner_body)
	
