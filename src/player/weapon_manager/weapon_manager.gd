extends Node

class_name Weapon_manager

signal swap_weapon
	
var can_swap_weapon = true

var weapon_1: Base_weapon = null
var weapon_2: Base_weapon = null

var active: Base_weapon = null
var active_id = 1
var active_sprite: Sprite = null

func get_active_weapon():
	return active

func load_weapon(name):
	var weapon = load("res://src/weapons/" + name + "/" + name + ".tscn")
	var instance: Base_weapon = weapon.instance()
	get_parent().STATS.connect("modify_lvl", instance, "upgrade_base_ability_by_lvl")
	if weapon_1 == null:
		get_parent().weapon_slot.add_child(instance)
		instance.use_in_hand()
		weapon_1 = instance
		active = instance
	elif weapon_2 == null:
		get_parent().off_wepon_slot.add_child(instance)
		instance.use_sheath()
		weapon_2 = instance
	elif active == weapon_1:
		get_parent().A_M.reset_weapon_ability(1)
		active.reset_all_ability()
		get_parent().weapon_slot.remove_child(active)
		get_parent().weapon_slot.add_child(instance)
		instance.use_in_hand()
		active = instance
		weapon_1 = instance
	elif active == weapon_2:
		get_parent().A_M.reset_weapon_ability(2)
		active.reset_all_ability()
		get_parent().weapon_slot.remove_child(active)
		get_parent().weapon_slot.add_child(instance)
		instance.use_in_hand()
		active = instance
		weapon_2 = instance

func swap_weapon():
	var is_have_unactive_weapon: bool = get_parent().off_wepon_slot.get_child_count() > 0
	
	if can_swap_weapon && is_have_unactive_weapon:
		var active_weapon: Base_weapon = get_parent().weapon_slot.get_child(0)
		var unactive_weapon: Base_weapon = get_parent().off_wepon_slot.get_child(0)
		get_parent().weapon_slot.remove_child(active_weapon)
		get_parent().off_wepon_slot.remove_child(unactive_weapon)
		
		active = unactive_weapon
		get_parent().weapon_slot.add_child(unactive_weapon)
		unactive_weapon.use_in_hand()
		get_parent().off_wepon_slot.add_child(active_weapon)
		active_weapon.use_sheath()
		
		if active_id == 1:
			active_id = 2
		else:
			active_id = 1
		can_swap_weapon = false
		emit_signal("swap_weapon")
		yield(get_tree().create_timer(1.0), "timeout")
		can_swap_weapon = true

func take_weapon(s: Base_item):
	pass
#	OBJECT_MANAGER.load_weapon_item(GAME_CORE.player.global_position, active.weapon_name)
#	load_weapon(GAME_CORE.player, s.item_name)

func reset_all_weapons():
	weapon_1 = null
	weapon_2 = null
