extends ViewportContainer

onready var HP_bar = $VBoxContainer/HP
onready var EXP_bar = $VBoxContainer/EXP
onready var LVL_input = $VBoxContainer/LVL
onready var menu = $PopupMenu

var player = null

## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


func _process(delta):
	HP_bar.value = player.HP
	EXP_bar.value = player.EXP

func load_player_info(playerInfo):
	player = playerInfo
	HP_bar.max_value = player.MAX_HP
	EXP_bar.max_value = player.MAX_EXP
	LVL_input.text = str(player.LVL)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		print('kek')
		menu.set_as_toplevel(true)
		menu.visible = true
