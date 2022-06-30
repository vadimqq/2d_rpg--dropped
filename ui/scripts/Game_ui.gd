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

var player = null

func _process(delta):
	HP_bar.value = player.HP
	MANA_bar.value = player.MANA
	EXP_bar.value = player.EXP
	skill_1_progress_bar.value = skill_timers['skill_1'].time_left

func load_player_info(playerInfo):
	player = playerInfo
	HP_bar.max_value = player.MAX_HP
	MANA_bar.max_value = player.MAX_MANA
	EXP_bar.max_value = player.MAX_EXP
	
	LVL_input.text = str(player.LVL)
	var cdr_value = player.skill_sistem['skill_1']['cd'] / 100 * player.cd_reduction
	
	skill_1_progress_bar.max_value = playerInfo.skill_sistem['skill_1']['cd'] - cdr_value


func start_skill_timer(name):
	player.skill_sistem[name]['is_cd'] = true
	var cdr_value = player.skill_sistem[name]['cd'] / 100 * player.cd_reduction
	
	skill_timers[name].wait_time = player.skill_sistem[name]['cd'] - cdr_value
	skill_timers[name].start()


func _on_skill_1_timer_timeout():
	player.skill_sistem['skill_1']['is_cd'] = false
	skill_timers['skill_1'].stop()
