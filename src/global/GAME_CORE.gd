extends Node

onready var player_src = preload("res://src/player/Player.tscn")
onready var game_ui_src = preload("res://src/ui/game_ui/game_ui.tscn")
onready var ability_board_src =  preload("res://src/ui/abilities_nodes/ability_board/ability_board.tscn")

var player: Player
var game_ui: Game_ui
var ability_board: Ability_board

var soul_stones = 0

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	player = player_src.instance()
	game_ui = game_ui_src.instance()
	ability_board = ability_board_src.instance()

func _process(delta):
	if Input.is_action_just_pressed("info_panel"):
		if get_tree().paused:
			close_info_panel()
		else:
			open_info_panel()

func start_game():
	get_tree().change_scene("res://src/levels/hub/hub.tscn")
#	get_tree().current_scene.add_child(player)
	player.add_child(game_ui)
	
	WEAPON_MANAGER.load_weapon(player, "bow")
	WEAPON_MANAGER.load_weapon(player, "sword")
	
	yield(get_tree(),"idle_frame")
	game_ui.init()
	

func end_game():
	pass


func open_info_panel():
	get_tree().paused = true
	player.add_child(ability_board)
	ability_board.open()

func close_info_panel():
	get_tree().paused = false
	player.remove_child(ability_board)
	
func modify_soul_stones(amount):
	soul_stones += amount
