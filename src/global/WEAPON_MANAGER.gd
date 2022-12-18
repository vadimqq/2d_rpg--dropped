extends Node

var can_swap_weapon = true

var weapon_1: Base_weapon = null
var weapon_2: Base_weapon = null

var active: Base_weapon = null
var active_id = 1
var active_sprite: Sprite = null

func _process(delta):
	pass

func load_weapon(s: Base_body, name):
	yield(get_tree(),"idle_frame")
	var weapon = load("res://src/weapons/" + name + "/" + name + ".tscn")
	var instance: Base_weapon = weapon.instance()
	
	if weapon_1 == null:
		s.weapon_slot.add_child(instance)
		instance.use_in_hand()
		weapon_1 = instance
		active = instance
	elif weapon_2 == null:
		s.off_wepon_slot.add_child(instance)
		instance.use_sheath()
		weapon_2 = instance
	elif active == weapon_1:
		SKILL_MANAGER.reset_weapon_ability(1)
		active.reset_all_ability()
		s.weapon_slot.remove_child(active)
		s.weapon_slot.add_child(instance)
		instance.use_in_hand()
		active = instance
		weapon_1 = instance
	elif active == weapon_2:
		SKILL_MANAGER.reset_weapon_ability(2)
		active.reset_all_ability()
		s.weapon_slot.remove_child(active)
		s.weapon_slot.add_child(instance)
		instance.use_in_hand()
		active = instance
		weapon_2 = instance

func swap_weapon(s: Base_body):
	var is_have_unactive_weapon: bool = s.off_wepon_slot.get_child_count() > 0
	
	if can_swap_weapon && is_have_unactive_weapon:
		var active_weapon: Base_weapon = s.weapon_slot.get_child(0)
		var unactive_weapon: Base_weapon = s.off_wepon_slot.get_child(0)
		s.weapon_slot.remove_child(active_weapon)
		s.off_wepon_slot.remove_child(unactive_weapon)
		
		active = unactive_weapon
		s.weapon_slot.add_child(unactive_weapon)
		unactive_weapon.use_in_hand()
		s.off_wepon_slot.add_child(active_weapon)
		active_weapon.use_sheath()
		
		if active_id == 1:
			active_id = 2
		else:
			active_id = 1
		GAME_CORE.game_ui.ability_list.set_icons()
		can_swap_weapon = false
		yield(get_tree().create_timer(1.0), "timeout")
		can_swap_weapon = true

func take_weapon(s: Base_item):
	OBJECT_MANAGER.load_weapon_item(GAME_CORE.player.global_position, active.weapon_name)
	load_weapon(GAME_CORE.player, s.item_name)

func reset_all_weapons():
	weapon_1 = null
	weapon_2 = null
