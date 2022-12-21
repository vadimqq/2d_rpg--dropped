extends Node

onready var player_src = preload("res://src/player/Player.tscn")
onready var ability_board_src =  preload("res://src/ui/abilities_nodes/ability_board/ability_board.tscn")
const void_imp = preload("res://src/enemies/void_imp/void_imp.tscn")
onready var game_statistic = preload("res://src/ui/game_statistic/game_statistic.tscn")

var player: Player
var ability_board: Ability_board

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

func restart_game():
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
