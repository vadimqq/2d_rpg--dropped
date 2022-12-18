extends Node

onready var player_src = preload("res://src/player/Player.tscn")
onready var ability_board_src =  preload("res://src/ui/abilities_nodes/ability_board/ability_board.tscn")
onready var level_master_src = preload("res://src/ui/level_master/level_master.tscn")

onready var game_statistic = preload("res://src/ui/game_statistic/game_statistic.tscn")

var player: Player
var ability_board: Ability_board

var game_lvl = 5
var time_left = 0 #всего прошло времени в игре
var lvl_time = 300 #время уровня
var enemy_killing = 0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	player = player_src.instance()
	ability_board = ability_board_src.instance()
	
func _process(delta):
	if Input.is_action_just_pressed("info_panel"):
		if get_tree().paused:
			close_info_panel()
		else:
			open_info_panel()

	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func start_game():
	LOCATION_MANAGER.load_location(LOCATION_MANAGER.generate_level)
	yield(get_tree(),"idle_frame")

func timer_tick():
	yield(get_tree().create_timer(1),"timeout")
	time_left += 1
	if fmod(time_left, 10) == 0:
		game_lvl += 1
	
	if lvl_time < time_left:
		complite_location()
	timer_tick()

func restart_game():
	game_lvl = 1
	time_left = 0
	enemy_killing = 0
	player = player_src.instance()
	ability_board = ability_board_src.instance()
	
	LOCATION_MANAGER.on_location = false
	OBJECT_MANAGER.reset_all_items()
	start_game()

func end_game():
	get_tree().change_scene("res://src/ui/game_statistic/game_statistic.tscn")

func open_info_panel():
	get_tree().paused = true
	player.add_child(ability_board)

func close_info_panel():
	get_tree().paused = false
	player.remove_child(ability_board)

func add_kill():
	enemy_killing += 1
	QUEST_MANAGER.check_quests()

func complite_location():
	time_left = 0
	LOCATION_MANAGER.load_location(LOCATION_MANAGER.GLADE)
