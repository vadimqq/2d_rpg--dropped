extends Container

onready var HP_bar = $VBoxContainer/HP
onready var MANA_bar = $VBoxContainer/MANA
onready var EXP_bar = $EXP
onready var LVL_input = $VBoxContainer/LVL
onready var skill_1_progress_bar = $HBoxContainer/skill_1/Texture_progress
onready var upgrade_menu = $Upgrade_menu

onready var skill_timers = {
	'skill_1': $HBoxContainer/skill_1/skill_1_timer
}

var stats = null

func _process(delta):
	if stats != null:
		HP_bar.value = stats.HP
		MANA_bar.value = stats.MANA
		EXP_bar.value = stats.EXP
		skill_1_progress_bar.value = skill_timers['skill_1'].time_left

func load_player_info(stats_instance):
	stats = stats_instance
	HP_bar.max_value = stats.MAX_HP
	MANA_bar.max_value = stats.MAX_MANA
	EXP_bar.max_value = stats.MAX_EXP
	
	LVL_input.text = str(stats.LVL)

func open_upgrade_menu(spirits_pivot):
	upgrade_menu.open_upgrade(spirits_pivot)
