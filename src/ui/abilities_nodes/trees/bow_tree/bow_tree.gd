extends VBoxContainer

onready var progress = $ProgressBar
onready var grade_button = $Button

onready var tier_1 = $HBoxContainer/Tier_1
onready var tier_2 = $HBoxContainer/Tier_2
onready var tier_3 = $HBoxContainer/Tier_3

onready var cost_upgrade = 1

func _ready():
	CURRENCY_MANAGER.connect("change_upgrade_points", self, "on_change_upgrade_points")

func _on_Button_pressed():
	upgrade_tree()

func upgrade_tree():
	CURRENCY_MANAGER.modify_upgrade_points(-cost_upgrade)
	progress.value += cost_upgrade
	GAME_CORE.player.STATS.apply_buff(stats)
	
	if progress.value == 5:
		for ability in tier_1.get_children():
				ability.set_unlock()
	elif progress.value == 10: 
		for ability in tier_2.get_children():
				ability.set_unlock()

func on_change_upgrade_points():
	if cost_upgrade > CURRENCY_MANAGER.upgrade_points:
		grade_button.disabled = true
	else:
		grade_button.disabled = false

var stats = {
	"HEALTH": 5,
	"HEALTH_REGEN": 0.2,
	"MANA": 2,
	"GAIN_ATTACK_SPEED": 1,
	"GAIN_DAMAGE": 0.3,
	"GAIN_PROJECTILE_SPEED": 0.3,
	"PHYSIC_DAMAGE": 1,
	"PHYSIC_RESIST": 0.3
}
