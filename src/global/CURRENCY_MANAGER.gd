extends Node

signal change_upgrade_points

var upgrade_points = 10

func modify_upgrade_points(amount):
	upgrade_points += amount
	emit_signal("change_upgrade_points")

func load_instance(name):
	var scene = load("res://src/currency/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance

func create_soul_coin(amount, spawn_position):
	var coin: Node2D = load_instance("soul_coin")
	coin.count = amount
	coin.global_position = spawn_position
	get_node("/root").call_deferred("add_child", coin)
