extends CanvasLayer
class_name Game_ui

const Stat_system = preload("res://src/scripts/stat_system.gd").STAT_SYSTEM

onready var health_bar = $ViewportContainer/HBoxContainer/VBoxContainer/HBoxContainer/Health
onready var health_label = $ViewportContainer/HBoxContainer/VBoxContainer/HBoxContainer/Label
onready var mana_bar = $ViewportContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Mana
onready var mana_label = $ViewportContainer/HBoxContainer/VBoxContainer/HBoxContainer2/Label
onready var lvl_label = $ViewportContainer/HBoxContainer/NinePatchRect/CenterContainer/lvl
onready var soul_coins_label = $ViewportContainer/HBoxContainer/VBoxContainer/Soul_coins
onready var active_weapon = $ViewportContainer/Weapon_container/Active_weapon
onready var ability_list = $ViewportContainer/Weapon_container/Ability_list
onready var passive_list = $ViewportContainer/Passive_list
onready var artifact_list = $ViewportContainer/Artifact_list


var stats: Stat_system = null

func init():
	stats = GAME_CORE.player.STATS

func _process(delta):
	lvl_label.text = str(stats.LVL)
	health_bar.max_value = stats.get_max_health()
	health_bar.value = stats.CURRENT_HEALTH
	health_label.text = str(stats.CURRENT_HEALTH) + "/" + str(stats.get_max_health())
	
	mana_bar.max_value = stats.get_max_mana()
	mana_bar.value = stats.CURRENT_MANA
	mana_label.text = str(stats.CURRENT_MANA) + "/" + str(stats.get_max_mana())

func add_passive_icon(element, name):
	var passive_icon_src = load("res://src/ui/abilities_nodes/passive_ability/passive_ability.tscn")
	var instance = passive_icon_src.instance()
	instance.texture = load("res://src/abilities/passive/" + element + "/" + name + "/icon.png")
	passive_list.add_child(instance)
	print(element, name)

func add_artifact_icon(name):
	var artifact_icon_src = load("res://src/ui/artifact/artifact.tscn")
	var instance = artifact_icon_src.instance()
	instance.name = name
	instance.texture = load("res://src/items/artifacts/" + name + "/icon.png")
	artifact_list.add_child(instance)

func update_artifact_count(name):
	for item in artifact_list.get_children():
		if item.name == name:
			item.add_count()

func update_souil_coins_count(amount):
	if soul_coins_label != null:
		soul_coins_label.text = "soul coins: " + str(amount)
