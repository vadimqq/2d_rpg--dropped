extends Node

var player = preload("res://src/player/Player.tscn")

var pig = preload("res://src/enemies/pig/pig.tscn")
var skull = preload("res://src/enemies/skull/skull.tscn")
var boss = preload("res://src/enemies/bosses/fire_slime/fire_slime.tscn")


signal on_open_portal()
signal on_portal_lvl_up()


var portal_lvl = 1
var enemy_spawn_speed = 2.0
var enemy_total_counter = 0
var player_instance = player.instance()

func update_protal_lvl():
	if lvl_info.has(portal_lvl + 1):
		portal_lvl += 1
		enemy_spawn_speed -= 0.3
		emit_signal("on_portal_lvl_up")

func get_lvl_info():
	return lvl_info[portal_lvl]

func open_portal():
	emit_signal("on_open_portal")

func get_enemy_total_counter():
	var result = 0
	for enemy in lvl_info[portal_lvl]:
		result += enemy['count']
	enemy_total_counter += result

func load_new_lvl():
	get_tree().change_scene("res://src/Arena.tscn")
	get_enemy_total_counter()

var lvl_info = {
	1: [
		{
			'node': pig,
			'count': 20
		},
	],
	2: [
		{
			'node': pig,
			'count': 25
		},
		{
			'node': skull,
			'count': 5
		}
	],
	3: [
		{
			'node': pig,
			'count': 40
		},
		{
			'node': skull,
			'count': 20
		}
	],
	4: [
		{
			'node': pig,
			'count': 80
		},
		{
			'node': skull,
			'count': 40
		}
	],
	5: [
		{
			'node': pig,
			'count': 80
		},
		{
			'node': skull,
			'count': 40
		}
	],
	6: [
		{
			'node': pig,
			'count': 80
		},
		{
			'node': skull,
			'count': 40
		}
	]
}
