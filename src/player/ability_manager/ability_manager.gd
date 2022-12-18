extends Node

var weapon_1_tier_1_ability: Base_ability = null
var weapon_1_tier_2_ability: Base_ability = null
var weapon_1_tier_3_ability: Base_ability = null
var weapon_1_tier_4_ability: Base_ability = null

var weapon_2_tier_1_ability: Base_ability = null
var weapon_2_tier_2_ability: Base_ability = null
var weapon_2_tier_3_ability: Base_ability = null
var weapon_2_tier_4_ability: Base_ability = null

var passive_abilities = []

func set_active_ability(ability_name):
	pass
#	var ability: Base_ability = ABILITY_MANAGER.get_ability_by_name(ability_name)
#	match ability.tier:
#		1:
#			self["weapon_" + str(get_parent().W_M.active_id) + "_tier_1_ability"] = ability
#			get_parent().W_M.active.set_ability_by_tier(ability)
#			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(1, ability_name)
#			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(1, ability_name)
#		2:
#			self["weapon_" + str(get_parent().W_M.active_id) + "_tier_2_ability"]  = ability
#			get_parent().W_M.active.set_ability_by_tier(ability)
#			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(2, ability_name)
#			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(2, ability_name)
#		3:
#			self["weapon_" + str(get_parent().W_M.active_id) + "_tier_3_ability"]  = ability
#			get_parent().W_M.active.set_ability_by_tier(ability)
#			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(3, ability_name)
#			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(3, ability_name)
#		4:
#			self["weapon_" + str(get_parent().W_M.active_id) + "_tier_4_ability"]  = ability
#			get_parent().W_M.active.set_ability_by_tier(ability)
#			GAME_CORE.game_ui.ability_list.set_ability_icon_by_slot(4, ability_name)
#			GAME_CORE.ability_board.ability_list.set_ability_icon_by_slot(4, ability_name)

func reset_weapon_ability(weapon):
	match weapon:
		1:
			if weapon_1_tier_1_ability != null && weapon_1_tier_1_ability.has_method("disable"):
				weapon_1_tier_1_ability.disable()
			weapon_1_tier_1_ability = null

			if weapon_1_tier_2_ability != null && weapon_1_tier_2_ability.has_method("disable"):
				weapon_1_tier_2_ability.disable()
			weapon_1_tier_2_ability = null

			if weapon_1_tier_3_ability != null && weapon_1_tier_3_ability.has_method("disable"):
				weapon_1_tier_3_ability.disable()
			weapon_1_tier_3_ability = null

			if weapon_1_tier_4_ability != null && weapon_1_tier_4_ability.has_method("disable"):
				weapon_1_tier_4_ability.disable()
			weapon_1_tier_4_ability = null
		2:
			if weapon_2_tier_1_ability != null && weapon_2_tier_1_ability.has_method("disable"):
				weapon_2_tier_1_ability.disable()
			weapon_2_tier_1_ability = null

			if weapon_2_tier_2_ability != null && weapon_2_tier_2_ability.has_method("disable"):
				weapon_2_tier_2_ability.disable()
			weapon_2_tier_2_ability = null

			if weapon_2_tier_3_ability != null && weapon_2_tier_3_ability.has_method("disable"):
				weapon_2_tier_3_ability.disable()
			weapon_2_tier_3_ability = null

			if weapon_2_tier_4_ability != null && weapon_2_tier_4_ability.has_method("disable"):
				weapon_2_tier_4_ability.disable()
			weapon_2_tier_4_ability = null
