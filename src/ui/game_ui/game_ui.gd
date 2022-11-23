extends CanvasLayer
class_name Game_ui

const Stat_system = preload("res://src/scripts/stat_system.gd").STAT_SYSTEM

onready var health_bar = $ViewportContainer/VBoxContainer/Health
onready var mana_bar = $ViewportContainer/VBoxContainer/Mana
onready var experience_bar = $ViewportContainer/VBoxContainer/Experience
onready var active_weapon = $ViewportContainer/Weapon_container/Active_weapon
onready var ability_list = $ViewportContainer/Weapon_container/Ability_list
onready var passive_list = $ViewportContainer/Passive_list
onready var artifact_list = $ViewportContainer/Artifact_list


var stats: Stat_system = null

func init():
	stats = GAME_CORE.player.STATS
	
	health_bar.max_value = stats.MAX_HP
	health_bar.value = stats.HP
	
	mana_bar.max_value = stats.MAX_MANA
	mana_bar.value = stats.MANA
	
	experience_bar.max_value = stats.MAX_EXP
	experience_bar.value = stats.EXP

func _process(delta):
	health_bar.value = stats.HP
	mana_bar.value = stats.MANA
	experience_bar.value = stats.EXP

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
