extends Node2D

class_name Base_ability

onready var cd_timer: Timer = $CD

var owner_body

export (int) var lvl = 0
export (int) var max_lvl = 1
var is_max_lvl = false
export (int) var price = 1
export (int) var mana_cost = 0
export (int) var health_cost = 0
export (int) var tier = 1

export (int) var bleed_chance = 0
export (int) var poision_chance = 0
export (int) var burn_chance = 0

export (Array, CONSTANTS.SCALING_TAG_ENUM) var scaling_tags = []
export (Array, CONSTANTS.WEAPON_TYPES) var weapon_tags = []

export (CONSTANTS.DAMAGE_TYPE_ENUM) var damage_type = CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC
export (CONSTANTS.ABILITY_TYPE_ENUM) var type = CONSTANTS.ABILITY_TYPE_ENUM.ACTIVE

export (int) var CD = 1
export (int) var damage_incounter = 100
var effect_tags = []

var is_ready = true

signal execute
signal upgrade
signal use_ability

func _ready():
	upgrade(lvl)

func upgrade(new_lvl = lvl + 1):
	emit_signal("upgrade",  new_lvl)
	if max_lvl == lvl:
		is_max_lvl = true

func _on_CD_timeout():
	is_ready = true

func start_cd():
	is_ready = false
	cd_timer.wait_time = owner_body.STATS.get_cd_by_value(CD)
	cd_timer.start()

func execute(s, spawn_position):
	owner_body = s
	effect_tags.clear()
	effect_tags.append_array(get_DOT_effects())
	var damage_weight = get_damage_weight()
	owner_body.STATS.modify_current_mana(-mana_cost)
	owner_body.STATS.modify_current_health(-health_cost)
	emit_signal("execute", spawn_position, get_damage_by_weight(damage_weight), damage_weight)
	emit_signal("use_ability")

func get_damage_weight():
	if UTILS.get_percent_proc(owner_body.STATS.get_critical_chance()):
		return CONSTANTS.DAMAGE_WEIGHT_ENUM.CRITICAL
	else:
		return CONSTANTS.DAMAGE_WEIGHT_ENUM.BASE

func get_damage_by_weight(damage_type):
	var damage = owner_body.STATS.get_calculated_damage(self) * (damage_incounter / 100)
	if damage_type == CONSTANTS.DAMAGE_WEIGHT_ENUM.CRITICAL:
		return damage * (owner_body.STATS.get_critical_damage() / 100)
	else:
		return damage

func get_DOT_effects():
	var DOT_tags = []
	check_amount_DOT(owner_body.STATS.get_chance_bleed(bleed_chance), CONSTANTS.EFFECT_TAG_ENUM.BLEED, DOT_tags)
	check_amount_DOT(owner_body.STATS.get_chance_poison(poision_chance), CONSTANTS.EFFECT_TAG_ENUM.POISON, DOT_tags)
	check_amount_DOT(owner_body.STATS.get_chance_burn(burn_chance), CONSTANTS.EFFECT_TAG_ENUM.BURN, DOT_tags)
	return DOT_tags

func check_amount_DOT(percent, type, pool):
	if percent > 100:
		var amount = percent / 100
		var remainder = amount
		for i in floor(amount):
			pool.push_back(type)
			remainder -= 1
		if UTILS.get_percent_proc(remainder * 100):
			pool.push_back(type)
	else:
		if UTILS.get_percent_proc(percent):
			pool.push_back(type)
