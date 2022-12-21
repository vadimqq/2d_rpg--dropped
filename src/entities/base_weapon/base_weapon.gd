extends Node2D
class_name Base_weapon

onready var sprite = $Sprite
onready var spawn_position = $Position

onready var base_ability: Base_ability = null
onready var ability_1: Base_ability = null
onready var ability_2: Base_ability = null
onready var ability_3: Base_ability = null
onready var ability_4: Base_ability = null

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

func get_base_ability():
	return base_ability

func get_ability_by_slot(id: int):
	return self["ability_" + str(id)]

func set_ability_by_tier(ability: Base_ability):
	var player: Base_body = find_parent("Player")
	
	match ability.tier:
		1:
			ability_1 = ability
		2:
			ability_2 = ability
		3:
			ability_3 = ability
		4:
			ability_4 = ability
		
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
	if ability_1 != null:
		ability_1.execute(owner_body, spawn_position.global_transform)

func second_ability():
	if ability_2 != null:
		ability_2.execute(owner_body, spawn_position.global_transform)

func third_ability():
	if ability_3 != null:
		ability_3.execute(owner_body, spawn_position.global_transform)

func fourth_ability():
	if ability_4 != null:
		ability_4.execute(owner_body, spawn_position.global_transform)

func remove_slot(slot: Node2D):
	for n in slot.get_children():
		slot.remove_child(n)

func upgrade_base_ability_by_lvl():
	var player = find_parent("Player")
	get_base_ability().upgrade(player.STATS.LVL)
