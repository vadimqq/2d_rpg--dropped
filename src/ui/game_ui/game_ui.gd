extends CanvasLayer
class_name Game_ui

onready var health_bar = $ViewportContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Health
onready var health_label = $ViewportContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Label
onready var mana_bar = $ViewportContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Mana
onready var mana_lock_bar = $ViewportContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Mana_lock
onready var mana_label = $ViewportContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Label
onready var exp_bar = $ViewportContainer/VBoxContainer/EXP_bar
onready var lvl_label = $ViewportContainer/VBoxContainer/HBoxContainer/CenterContainer/NinePatchRect/CenterContainer/lvl
onready var weapon_ability: Ability_ui = $ViewportContainer/Weapon_container/Weapon_ability
onready var ability_list = $ViewportContainer/Weapon_container/Ability_list
onready var passive_list = $ViewportContainer/Passive_list
onready var artifact_list = $ViewportContainer/Artifact_list
onready var quest_list: VBoxContainer = $ViewportContainer/Quest_list

signal modify_health
signal modify_mana
signal modify_EXP
signal modify_LVL

func connect_stats_system(stats: Stat_system):
	stats.connect("modify_health", self, "set_health_info", [stats])
	stats.connect("modify_mana", self, "set_mana_info", [stats])
	stats.connect("modify_EXP", self, "set_health_info", [stats])
	stats.connect("modify_LVL", self, "set_lvl_info", [stats])
	
	set_health_info(stats)
	set_lvl_info(stats)
	set_mana_info(stats)
	set_exp_info(stats)

func set_health_info(stats: Stat_system):
	health_bar.max_value = stats.get_max_health()
	health_bar.value = stats.CURRENT_HEALTH
	health_label.text = str(ceil(stats.CURRENT_HEALTH)) + "/" + str(stats.get_max_health())

func set_lvl_info(stats: Stat_system):
	lvl_label.text = str(stats.LVL)

func set_mana_info(stats: Stat_system):
	mana_bar.max_value = stats.get_max_mana()
	mana_bar.value = stats.CURRENT_MANA
	mana_lock_bar.value = stats.get_mana_locked()
	mana_label.text = str(ceil(stats.CURRENT_MANA)) + "/" + str(stats.get_max_mana())

func set_exp_info(stats: Stat_system):
	exp_bar.max_value = stats.MAX_EXP
	exp_bar.value = stats.CURRENT_EXP

func connect_weapon_manager(weapon_manager: Weapon_manager):
	yield(get_tree(), "idle_frame")
	weapon_manager.connect("swap_weapon", self, "set_weapon_ability", [weapon_manager])
	set_weapon_ability(weapon_manager)

func set_weapon_ability(weapon_manager: Weapon_manager):
	var active_weapon: Base_weapon = weapon_manager.get_active_weapon()
	
	var base_ability: Base_ability = active_weapon.get_base_ability()
	weapon_ability.connect_ability(base_ability)
	
	var first_ability: Base_ability = active_weapon.get_ability_by_slot(1)
	ability_list.slot_1.connect_ability(first_ability)

	var second_ability: Base_ability = active_weapon.get_ability_by_slot(2)
	ability_list.slot_2.connect_ability(second_ability)
	
	var third_ability: Base_ability = active_weapon.get_ability_by_slot(3)
	ability_list.slot_3.connect_ability(third_ability)
	
	var fourth_ability: Base_ability = active_weapon.get_ability_by_slot(4)
	ability_list.slot_4.connect_ability(fourth_ability)

#func add_passive_icon(element, name):
#	var passive_icon_src = load("res://src/ui/abilities_nodes/passive_ability/passive_ability.tscn")
#	var instance = passive_icon_src.instance()
#	instance.texture = load("res://src/abilities/passive/" + element + "/" + name + "/icon.png")
#	passive_list.add_child(instance)
#	print(element, name)
#
#func add_artifact_icon(id):
#	var artifact_icon_src = load("res://src/ui/artifact/artifact.tscn")
#	var instance = artifact_icon_src.instance()
#	instance.id = id
#	instance.texture = load("res://src/items/artifacts/" + id + "/icon.png")
#	artifact_list.add_child(instance)
#
#func update_artifact_count(id):
#	for item in artifact_list.get_children():
#		if item.id == id:
#			item.add_count()
