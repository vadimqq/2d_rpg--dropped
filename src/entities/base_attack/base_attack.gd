extends Area2D

class_name Base_attack

var owner_body = null

var damage = 0
var crit_chance = 0
var crit_damage = 0
var type = null
var area_size = 0
var speed = 0
var attack_type = CONSTANTS.CAST_TYPE_ENUM.BASE
var DOT_tags = []

func check_crit_chance(c_chance, c_damage):
	if is_percent_proc(crit_chance):
		damage = damage + damage / 100 * crit_damage
		attack_type = CONSTANTS.CAST_TYPE_ENUM.CRITICAL

func is_percent_proc(chance):
	var percent = randf()
	return percent < chance / 100

func check_DOT_chance(s):
	check_amount_DOT(s.STATS.CHANCE_BLEED, CONSTANTS.DOT_TYPE_ENUM.BLEED)
	check_amount_DOT(s.STATS.CHANCE_POISION, CONSTANTS.DOT_TYPE_ENUM.POISION)
	check_amount_DOT(s.STATS.CHANCE_BURN, CONSTANTS.DOT_TYPE_ENUM.BURN)

func check_amount_DOT(percent, type):
	if percent > 100:
		var amount = percent / 100
		var remainder = amount
		for i in floor(amount):
			DOT_tags.push_back(type)
			remainder -= 1
		if is_percent_proc(remainder * 100):
			DOT_tags.push_back(type)
	else:
		if is_percent_proc(percent):
			DOT_tags.push_back(type)

func load_info(s, spawn_position, projectile_rotation):
	owner_body = s
	damage = s.STATS.DAMAGE
	crit_chance = s.STATS.CRIT_CHANCE
	crit_damage = s.STATS.CRIT_DAMAGE
	speed = s.STATS.PROJECTILE_SPEED
	transform = spawn_position
	rotation = projectile_rotation

	scale.x = scale.x + scale.x / 100 * s.STATS.INCREASE_AREA
	scale.y = scale.y + scale.y / 100 * s.STATS.INCREASE_AREA

	self.collision_layer = s.attack_layer
	self.collision_mask = s.attack_mask
	check_crit_chance(crit_chance, crit_damage)
	check_DOT_chance(s)

