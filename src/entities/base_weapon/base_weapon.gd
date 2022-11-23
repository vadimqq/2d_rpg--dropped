extends Node2D
class_name Base_weapon

onready var sprite = $Sprite
onready var spawn_position = $Position

onready var slot_1 = $Abilities/Slot_1
onready var slot_2 = $Abilities/Slot_2
onready var slot_3 = $Abilities/Slot_3
onready var slot_4 = $Abilities/Slot_4

var tags = []
var weapon_name = ''
var owner_body: Base_body = null
var attack_range = 0
var in_sheath = false

signal use_sheath
signal use_in_hand

signal use_weapon_ability

signal use_first_ability
signal use_second_ability
signal use_third_ability
signal use_fourth_ability

func use_sheath():
	in_sheath = true
	emit_signal("use_sheath")

func use_in_hand():
	in_sheath = false
	emit_signal("use_in_hand")

func set_ability_by_tier(ability: Base_ability):
	match ability.tier:
		1:
			remove_slot(slot_1)
			slot_1.add_child(ability)
		2:
			remove_slot(slot_2)
			slot_2.add_child(ability)
		3:
			remove_slot(slot_3)
			slot_3.add_child(ability)
		4:
			remove_slot(slot_4)
			slot_4.add_child(ability)
		
func use_weapon_ability(s):
	owner_body = s
	emit_signal("use_weapon_ability")

func use_first_ability(s):
	owner_body = s
	first_ability()

func use_second_ability(s):
	owner_body = s
	second_ability()

func use_third_ability(s):
	owner_body = s
	third_ability()

func use_fourth_ability(s):
	owner_body = s
	fourth_ability()

func first_ability():
	if slot_1.get_child_count() > 0:
		var ability: Base_ability = slot_1.get_child(0)
		ability.execute(owner_body, spawn_position.global_transform)

func second_ability():
	if slot_2.get_child_count() > 0:
		var ability: Base_ability = slot_2.get_child(0)
		ability.execute(owner_body, spawn_position.global_transform)

func third_ability():
	if slot_3.get_child_count() > 0:
		var ability: Base_ability = slot_3.get_child(0)
		ability.execute(owner_body, spawn_position.global_transform)

func fourth_ability():
	if slot_4.get_child_count() > 0:
		var ability: Base_ability = slot_4.get_child(0)
		ability.execute(owner_body, spawn_position.global_transform)

func remove_slot(slot: Node2D):
	for n in slot.get_children():
		slot.remove_child(n)

func get_ability_by_slot_id(id):
	match id:
		1:
			return  slot_1.get_child(0) if slot_1.get_child_count() > 0 else null
		2:
			return slot_2.get_child(0) if slot_2.get_child_count() > 0 else null
		3:
			return slot_3.get_child(0) if slot_3.get_child_count() > 0 else null
		4:
			return slot_4.get_child(0) if slot_4.get_child_count() > 0 else null

func reset_all_ability():
	remove_slot(slot_1)
	remove_slot(slot_2)
	remove_slot(slot_3)
	remove_slot(slot_4)
