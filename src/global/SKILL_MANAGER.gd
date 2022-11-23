extends Node

#PASSIVE==========================================================
var physic_attack_speed: Base_ability = load_passive_instance("physic", "attack_speed")
var physic_bleed: Base_ability = load_passive_instance("physic", "bleed")

#ACTIVE===========================================================
var lightning_bolt: Base_ability = load_instance("lightning_bolt")
var arrow_multishot: Base_ability = load_instance("arrow_multishot")
var dash: Base_ability = load_instance("dash")

var weapon_1_tier_1_ability = null
var weapon_1_tier_2_ability = null
var weapon_1_tier_3_ability = null
var weapon_1_tier_4_ability = null

var weapon_2_tier_1_ability = null
var weapon_2_tier_2_ability = null
var weapon_2_tier_3_ability = null
var weapon_2_tier_4_ability = null

var passive_abilities = []

func load_ability(s: Base_weapon, name, lvl = 1):
	var instance: Base_ability = load_instance(name)
	instance.upgrade(lvl)
	s.add_child(instance)
	return instance

func load_instance(name):
	var scene = load("res://src/abilities/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance

func load_passive_instance(element, name):
	var scene = load("res://src/abilities/passive/" + element + "/" + name + "/" + name + ".tscn")
	var instance = scene.instance()
	return instance

func get_ability_by_name(ability_name):
	return self[ability_name]

func upgrade_ability(ability_name):
	var ability: Base_ability = get_ability_by_name(ability_name)
	ability.upgrade(GAME_CORE.player)
	if ability.type == CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE && ability.lvl == 1:
		GAME_CORE.game_ui.add_passive_icon(ability.element, ability.name)

func set_active_ability(ability_name):
	var ability: Base_ability = get_ability_by_name(ability_name)
	match ability.tier:
		1:
			self["weapon_" + str(WEAPON_MANAGER.active_id) + "_tier_1_ability"] = ability
			WEAPON_MANAGER.active.set_ability_by_tier(ability)
			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(1, ability_name)
			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(1, ability_name)
		2:
			self["weapon_" + str(WEAPON_MANAGER.active_id) + "_tier_2_ability"]  = ability
			WEAPON_MANAGER.active.set_ability_by_tier(ability)
			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(2, ability_name)
			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(2, ability_name)
		3:
			self["weapon_" + str(WEAPON_MANAGER.active_id) + "_tier_3_ability"]  = ability
			WEAPON_MANAGER.active.set_ability_by_tier(ability)
			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(3, ability_name)
			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(3, ability_name)
		4:
			self["weapon_" + str(WEAPON_MANAGER.active_id) + "_tier_4_ability"]  = ability
			WEAPON_MANAGER.active.set_ability_by_tier(ability)
			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(4, ability_name)
			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(4, ability_name)

func reset_weapon_ability(weapon):
	match weapon:
		1:
			weapon_1_tier_1_ability = null
			weapon_1_tier_2_ability = null
			weapon_1_tier_3_ability = null
			weapon_1_tier_4_ability = null
		2:
			weapon_2_tier_1_ability = null
			weapon_2_tier_2_ability = null
			weapon_2_tier_3_ability = null
			weapon_2_tier_4_ability = null
