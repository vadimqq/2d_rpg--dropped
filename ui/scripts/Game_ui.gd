extends Container

onready var HP_bar = $VBoxContainer/HP
onready var EXP_bar = $VBoxContainer/EXP

onready var LVL_input = $LVL
onready var upgrade_menu = $Upgrade_menu
onready var kills_enemy = $Kills_counter
onready var portal_lvl = $Portal_lvl

var stats = null
func _ready():
	pass
#		Game.connect("on_portal_lvl_up",self,"portal_lvl_up_view")

func _process(delta):
	if stats != null:
		HP_bar.value = stats.HP
		EXP_bar.value = stats.EXP
		kills_enemy.text = 'KILLS: ' + str(GAME_CORE.enemy_total_kill)


func portal_lvl_up_view():
	portal_lvl.text = 'PORTAL LVL: ' + str(GAME_CORE.portal_lvl)

func load_player_info(stats_instance):
	stats = stats_instance
	HP_bar.max_value = stats.MAX_HP
	EXP_bar.max_value = stats.MAX_EXP
	
	LVL_input.text = 'lvl ' + str(stats.LVL)

func open_upgrade_menu(spirits_pivot):
	upgrade_menu.open_upgrade(spirits_pivot)

