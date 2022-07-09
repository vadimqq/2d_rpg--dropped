extends Node

var main_menu = preload("res://ui/Root_menu.tscn")
var game_menu = preload("res://ui/Game_menu.tscn")

var lvl_meadow = preload("res://src/levels/meadow/meadow.tscn")
var spawner = preload("res://src/enemies/Spawner.tscn")
var lvl_portal = preload("res://src/neutral_Object/lvl_portal/lvl_portal.tscn")

var player = preload("res://src/player/Player.tscn")

var pig = preload("res://src/enemies/pig/pig.tscn")
var skull = preload("res://src/enemies/skull/skull.tscn")

enum {
	IN_GAME,
	IN_MAIN_MENU,
	IN_GAME_MENU
}
var game_state = IN_MAIN_MENU

var portal_lvl = 1
var enemy_lvl_counter = 0
var enemy_total_kill = 0
var enemy_spawn_speed = 2.0

var player_instance = player.instance()

var game_menu_instance = game_menu.instance()

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	open_main_menu()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		match game_state:
			IN_MAIN_MENU:
				close_main_menu()
			IN_GAME_MENU:
				close_game_menu()
			IN_GAME:
				open_game_menu()

# Взаимодействие с меню
func open_main_menu():
	game_state = IN_MAIN_MENU
	get_tree().change_scene("res://ui/Root_menu.tscn")
	get_tree().paused = false

func close_main_menu():
	get_tree().quit()

func open_game_menu():
	game_state = IN_GAME_MENU
	get_tree().current_scene.add_child(game_menu_instance)
	get_tree().paused = true

func close_game_menu():
	game_state = IN_GAME
	get_tree().current_scene.remove_child(game_menu_instance)
	get_tree().paused = false

# Взаимодейтвие с уровнями
func load_lvl():
	game_state = IN_GAME
	get_tree().change_scene("res://src/levels/meadow/meadow.tscn")
	get_enemy_total_counter()

func up_portal_lvl():
	if lvl_info.has(portal_lvl + 1):
		portal_lvl += 1
	else:
		print('end game')
		pass
	enemy_spawn_speed -= 0.3
	get_tree().current_scene.remove_child(player_instance)
	
	load_lvl()

func get_lvl_info():
	return lvl_info[portal_lvl]

func get_enemy_total_counter():
	var result = 0
	for enemy in lvl_info[portal_lvl]:
		result += enemy['count']
	enemy_lvl_counter += result

func enemy_death(global_position):
	enemy_total_kill += 1
	if enemy_lvl_counter == enemy_total_kill:
		var lvl_portal_instance = lvl_portal.instance()
		get_tree().current_scene.add_child(lvl_portal_instance)
		lvl_portal_instance.global_position = global_position

var lvl_info = {
	1: [
		{
			'node': pig,
			'count': 1
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
	]
}
