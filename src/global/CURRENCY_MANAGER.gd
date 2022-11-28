extends Node

var soul_coins = 10000

func modify_soul_coins(amount):
	soul_coins += amount
	GAME_CORE.game_ui.update_souil_coins_count(soul_coins)

func load_instance(name):
	var scene = load("res://src/currency/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance

func create_soul_coin(amount, spawn_position):
	var coin: Node2D = load_instance("soul_coin")
	coin.count = amount
	coin.global_position = spawn_position
	get_node("/root").call_deferred("add_child", coin)
