extends VBoxContainer

onready var tier_1 = $HBoxContainer/Tier_1
onready var tier_2 = $HBoxContainer/Tier_2
onready var tier_3 = $HBoxContainer/Tier_3
onready var tier_4 = $HBoxContainer/Tier_4
onready var tier_5 = $HBoxContainer/Tier_5
onready var tier_6 = $HBoxContainer/Tier_6


onready var progress = $ProgressBar
onready var grade_button = $Button

onready var attack_speed = $HBoxContainer/Tier_1/attack_speed
onready var arrow_multishot = $HBoxContainer/Tier_2/arrow_multishot
onready var bleed = $HBoxContainer/Tier_2/bleed
onready var dash = $HBoxContainer/Tier_3/dash
onready var sword_vortex = $HBoxContainer/Tier_3/sword_vortex

func load_info():
	arrow_multishot.ability_name = "arrow_multishot"
	arrow_multishot.load_info()
	
	dash.ability_name = "dash"
	dash.load_info()
	
	attack_speed.ability_name = "physic_attack_speed"
	attack_speed.ability_type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	attack_speed.load_info()
	
	bleed.ability_name = "physic_bleed"
	bleed.ability_type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	bleed.load_info()

	sword_vortex.ability_name = "sword_vortex"
	sword_vortex.ability_type = CONSTANTS.ABILITY_TYPE_ENUM.MAINTAIN
	sword_vortex.load_info()
	check_disabled()

func check_disabled():
	if progress.value < 50:
		for ability in tier_1.get_children():
			ability.button.disabled = true
			ability.button.modulate = "#6d6d6d"
	else:
		for ability in tier_1.get_children():
			ability.load_info()

	if progress.value < 150:
		for ability in tier_2.get_children():
			ability.button.modulate = "#6d6d6d"
			ability.button.disabled = true
	else:
		for ability in tier_2.get_children():
			ability.load_info()
	
	if progress.value < 300:
		for ability in tier_3.get_children():
			ability.button.disabled = true
			ability.button.modulate = "#6d6d6d"
			
	else:
		for ability in tier_3.get_children():
			ability.load_info()
			

func _on_Button_pressed():
	CURRENCY_MANAGER.modify_soul_coins(-50)
	progress.value += 50
	GAME_CORE.player.STATS.apply_buff(stats)
	GAME_CORE.player.STATS.upgrade_lvl()
	load_info()

var stats = {
	"HEALTH": 5,
	"HEALTH_REGEN": 0.3,
	"MANA": 2,
	"GAIN_ATTACK_SPEED": 20,
	"GAIN_DAMAGE": 1,
	"PHYSIC_DAMAGE": 1,
	"PHYSIC_RESIST": 0.5
}
