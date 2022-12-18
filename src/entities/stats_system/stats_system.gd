extends Node

class_name Stat_system

signal modify_health
signal modify_mana
signal modify_EXP
signal modify_LVL

var LVL = 1
var CURRENT_EXP = 0
export (int) var MAX_EXP = 50
export (float) var EXP_MULTIPLIER = 1.2

#	NON MODIFY STATS:
export (int) var HEALTH = 30.0
export (float) var HEALTH_REGEN = 0.3

export (int) var MANA = 25.0
export (float) var MANA_REGEN = 0.3
var LOCKED_MANA = 0.0

export (float) var MOVE_SPEED = 50.0

export (float) var ATTACK_SPEED = 1.0

export (float) var PHYSIC_DAMAGE = 5.0
export (float) var VOID_DAMAGE = 5.0
export (float) var FIRE_DAMAGE = 5.0
export (float) var NATURE_DAMAGE = 5.0

export (float) var CRIT_CHANCE = 3.0
export (float) var CRIT_DAMAGE = 50.0

export (float) var VOID_RESIST = 5.0
export (float) var NATURE_RESIST = 5.0
export (float) var LIGHTING_RESIST = 5.0
export (float) var FIRE_RESIST = 5.0
export (float) var PHYSIC_RESIST = 5.0

export (float) var BLEED_DAMAGE = 0.0
export (float) var POISON_DAMAGE = 0.0
export (float) var BURN_DAMAGE = 0.0

export (int)  var CAST_DURATION = 100
export (int)  var INCREASE_AREA = 100
export (int)  var CDR = 100
export (int)  var KNOCKBACK_POWER = 3

#	CURRENT STATS:
var CURRENT_HEALTH = 0.0
var CURRENT_MANA = 0.0

#	GAIN STATS IN PERCENT:
export (int) var GAIN_HEALTH = 0
var GAIN_HEALTH_REGEN = 0

export (int) var GAIN_MANA = 0
export (int) var GAIN_MANA_REGEN = 0

export (int) var GAIN_MOVE_SPEED = 0

export (int) var GAIN_ATTACK_SPEED = 0
export (int) var GAIN_PROJECTILE_SPEED = 0

export (int) var GAIN_DAMAGE = 0
export (int) var GAIN_PHYSIC_DAMAGE = 0
export (int) var GAIN_VOID_DAMAGE = 0
export (int) var GAIN_FIRE_DAMAGE = 0
export (int) var GAIN_NATURE_DAMAGE = 0

export (int) var GAIN_CRIT_CHANCE = 0
export (int) var GAIN_CRIT_DAMAGE = 0

export (int) var GAIN_CAST_DURATION = 0
export (int) var GAIN_INCREASE_AREA = 0
export (int) var GAIN_CDR = 0
export (int) var GAIN_KNOCKBACK_POWER = 0

export (int) var GAIN_VOID_RESIST = 0
export (int) var GAIN_NATURE_RESIST = 0
export (int) var GAIN_LIGHTING_RESIST = 0
export (int) var GAIN_FIRE_RESIST = 0
export (int) var GAIN_PHYSIC_RESIST = 0

export (int) var GAIN_CHANCE_BLEED = 0
export (int) var GAIN_CHANCE_POISON = 0
export (int) var GAIN_CHANCE_BURN = 0

export (int) var GAIN_BLEED_DAMAGE = 0
export (int) var GAIN_POISON_DAMAGE = 0
export (int) var GAIN_BURN_DAMAGE = 0

export (int) var GAIN_DAMAGE_OVER_TIME = 0

export (int) var GAIN_PROJECTILE_DAMAGE = 0
export (int) var GAIN_ATTACK_DAMAGE = 0
export (int) var GAIN_SPELL_DAMAGE = 0

#	AMPLIFY STATS IN PERCENT
export (int) var AMPLIFICATION_HEALTH = 0
export (int) var AMPLIFICATION_HEALTH_REGEN = 0

export (int) var AMPLIFICATION_MANA = 0
export (int) var AMPLIFICATION_MANA_REGEN = 0

export (int) var AMPLIFICATION_MOVE_SPEED = 0

export (int) var AMPLIFICATION_ATTACK_SPEED = 0
export (int) var AMPLIFICATION_PROJECTILE_SPEED = 0

export (int) var AMPLIFICATION_DAMAGE = 0
export (int) var AMPLIFICATION_PHYSIC_DAMAGE = 0
export (int) var AMPLIFICATION_VOID_DAMAGE = 0
export (int) var AMPLIFICATION_FIRE_DAMAGE = 0
export (int) var AMPLIFICATION_NATURE_DAMAGE = 0

export (int) var AMPLIFICATION_CRIT_CHANCE = 0
export (int) var AMPLIFICATION_CRIT_DAMAGE = 0

export (int) var AMPLIFICATION_CAST_DURATION = 0
export (int) var AMPLIFICATION_INCREASE_AREA = 0
export (int) var AMPLIFICATION_KNOCKBACK_POWER = 0

export (int) var AMPLIFICATION_VOID_RESIST = 0
export (int) var AMPLIFICATION_NATURE_RESIST = 0
export (int) var AMPLIFICATION_LIGHTING_RESIST = 0
export (int) var AMPLIFICATION_FIRE_RESIST = 0
export (int) var AMPLIFICATION_PHYSIC_RESIST = 0

export (int) var AMPLIFICATION_CHANCE_BLEED = 0
export (int) var AMPLIFICATION_CHANCE_POISON = 0
export (int) var AMPLIFICATION_CHANCE_BURN = 0

export (int) var AMPLIFICATION_BLEED_DAMAGE = 0
export (int) var AMPLIFICATION_POISON_DAMAGE = 0
export (int) var AMPLIFICATION_BURN_DAMAGE = 0

export (int) var AMPLIFICATION_DAMAGE_OVER_TIME = 0

export (int) var AMPLIFICATION_PROJECTILE_DAMAGE = 0
export (int) var AMPLIFICATION_ATTACK_DAMAGE = 0
export (int) var AMPLIFICATION_SPELL_DAMAGE = 0

func _ready():
	CURRENT_HEALTH = HEALTH
	CURRENT_MANA = MANA

func get_incremented_value(value, gain, amplification):
	var gained_value = value + value / 100 * gain
	return float(gained_value +  gained_value / 100 * amplification)

func get_max_health():
	return get_incremented_value(HEALTH, GAIN_HEALTH, AMPLIFICATION_HEALTH)

func get_health_regen():
	return get_incremented_value(HEALTH_REGEN, GAIN_HEALTH_REGEN, AMPLIFICATION_HEALTH_REGEN)

func get_max_mana():
	return get_incremented_value(MANA, GAIN_MANA, AMPLIFICATION_MANA)

func get_mana_locked():
	return get_incremented_value(LOCKED_MANA, 0, 0)

func get_locked_mana_value():
	return get_max_mana() / 100 * get_mana_locked()

func get_mana_regen():
	return get_incremented_value(MANA_REGEN, GAIN_MANA_REGEN, AMPLIFICATION_MANA_REGEN)

func get_move_speed():
	return get_incremented_value(MOVE_SPEED, GAIN_MOVE_SPEED, AMPLIFICATION_MOVE_SPEED)

func get_attack_speed():
	return get_incremented_value(ATTACK_SPEED, GAIN_ATTACK_SPEED, AMPLIFICATION_ATTACK_SPEED)

func get_projectile_speed(amount):
	return get_incremented_value(amount, GAIN_PROJECTILE_SPEED, AMPLIFICATION_PROJECTILE_SPEED)

func get_calculated_damage(ability: Base_ability):
	var flat_damage = 0
	var gain_damage = GAIN_DAMAGE
	var amplification_damage = AMPLIFICATION_DAMAGE

	match ability.damage_type:
		CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC:
			flat_damage = PHYSIC_DAMAGE
			gain_damage = GAIN_PHYSIC_DAMAGE
			amplification_damage = AMPLIFICATION_PHYSIC_DAMAGE
		CONSTANTS.DAMAGE_TYPE_ENUM.FIRE:
			flat_damage = FIRE_DAMAGE
			gain_damage = GAIN_FIRE_DAMAGE
			amplification_damage = AMPLIFICATION_FIRE_DAMAGE

	for tag in ability.scaling_tags:
		match tag:
			CONSTANTS.SCALING_TAG_ENUM.PROJECTILE:
				gain_damage += GAIN_PROJECTILE_DAMAGE
				amplification_damage += AMPLIFICATION_PROJECTILE_DAMAGE
			CONSTANTS.SCALING_TAG_ENUM.DAMAGE_OVER_TIME:
				gain_damage += GAIN_DAMAGE_OVER_TIME
				amplification_damage += AMPLIFICATION_DAMAGE_OVER_TIME
			CONSTANTS.SCALING_TAG_ENUM.AOE:
				pass
			CONSTANTS.SCALING_TAG_ENUM.AURA:
				pass
			CONSTANTS.SCALING_TAG_ENUM.ATTACK:
				gain_damage += GAIN_ATTACK_DAMAGE
				amplification_damage += AMPLIFICATION_ATTACK_DAMAGE
			CONSTANTS.SCALING_TAG_ENUM.SPELL:
				gain_damage += GAIN_SPELL_DAMAGE
				amplification_damage += AMPLIFICATION_SPELL_DAMAGE
	return get_incremented_value(flat_damage, gain_damage, amplification_damage)

func get_critical_chance():
	return get_incremented_value(CRIT_CHANCE, GAIN_CRIT_CHANCE, AMPLIFICATION_CRIT_CHANCE)

func get_critical_damage():
	return get_incremented_value(CRIT_DAMAGE, GAIN_CRIT_DAMAGE, AMPLIFICATION_CRIT_DAMAGE)

func get_void_resist():
	return get_incremented_value(VOID_RESIST, GAIN_VOID_RESIST, AMPLIFICATION_VOID_RESIST)

func get_nature_resist():
	return get_incremented_value(NATURE_RESIST, GAIN_NATURE_RESIST, AMPLIFICATION_NATURE_RESIST)

func get_lightning_resist():
	return get_incremented_value(LIGHTING_RESIST, GAIN_LIGHTING_RESIST, AMPLIFICATION_LIGHTING_RESIST)

func get_fire_resist():
	return get_incremented_value(FIRE_RESIST, GAIN_FIRE_RESIST, AMPLIFICATION_FIRE_RESIST)

func get_physic_resist():
	return get_incremented_value(PHYSIC_RESIST, GAIN_PHYSIC_RESIST, AMPLIFICATION_PHYSIC_RESIST)

func get_chance_bleed(amount):
	return get_incremented_value(amount, GAIN_CHANCE_BLEED, AMPLIFICATION_CHANCE_BLEED)

func get_chance_poison(amount):
	return get_incremented_value(amount, GAIN_CHANCE_POISON, AMPLIFICATION_CHANCE_POISON)

func get_chance_burn(amount):
	return get_incremented_value(amount, GAIN_CHANCE_BURN, AMPLIFICATION_CHANCE_BURN)

func get_bleed_damage(amount):
	return get_incremented_value(BLEED_DAMAGE + amount, GAIN_BLEED_DAMAGE + GAIN_DAMAGE_OVER_TIME, AMPLIFICATION_BLEED_DAMAGE + AMPLIFICATION_DAMAGE_OVER_TIME)

func get_poison_damage(amount):
	return get_incremented_value(POISON_DAMAGE + amount, GAIN_POISON_DAMAGE + GAIN_DAMAGE_OVER_TIME, AMPLIFICATION_POISON_DAMAGE + AMPLIFICATION_DAMAGE_OVER_TIME)

func get_burn_damage(amount):
		return get_incremented_value(BURN_DAMAGE + amount, GAIN_POISON_DAMAGE + GAIN_DAMAGE_OVER_TIME, AMPLIFICATION_BURN_DAMAGE + AMPLIFICATION_DAMAGE_OVER_TIME)

func get_increase_area():
	return get_incremented_value(INCREASE_AREA, GAIN_INCREASE_AREA, AMPLIFICATION_INCREASE_AREA)

func get_cast_duration():
	return get_incremented_value(CAST_DURATION, GAIN_CAST_DURATION, AMPLIFICATION_CAST_DURATION)

func get_cdr():
	return CDR - GAIN_CDR

func get_cd_by_value(value):
	return UTILS.get_value_by_percent(value, get_cdr())

func get_knockback_power():
	return get_incremented_value(KNOCKBACK_POWER, GAIN_KNOCKBACK_POWER, AMPLIFICATION_KNOCKBACK_POWER)


func apply_damage_and_return(type, amount: int):
	var applied_damage = 0
	if(type == CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC):
		applied_damage = amount - UTILS.get_value_by_percent(amount, get_physic_resist())
	elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.VOID):
		applied_damage = amount - UTILS.get_value_by_percent(amount, get_void_resist())
	elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.FIRE):
		applied_damage = amount - UTILS.get_value_by_percent(amount, get_fire_resist())
	elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.LIGHTING):
		applied_damage = amount - UTILS.get_value_by_percent(amount, get_lightning_resist())
	elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.NATURE):
		applied_damage = amount - UTILS.get_value_by_percent(amount, get_nature_resist())

	modify_current_health(-ceil(applied_damage))
	return ceil(applied_damage)

func modify_current_health(amount):
	CURRENT_HEALTH += amount
	emit_signal("modify_health")

func regen_helth(): 
	if (CURRENT_HEALTH + get_health_regen() < get_max_health()):
		modify_current_health(get_health_regen())
	else:
		CURRENT_HEALTH = get_max_health()

func modify_current_mana(amount):
	CURRENT_MANA += amount
	emit_signal("modify_mana")

func regen_mana(): 
	if (CURRENT_MANA + get_mana_regen() < get_max_mana() - get_locked_mana_value()):
		modify_current_mana(get_mana_regen())
	else:
		CURRENT_MANA = get_max_mana() - get_locked_mana_value()

func modify_exp(amount):
	if CURRENT_EXP + amount >= MAX_EXP:
		var remainder =  CURRENT_EXP + amount - MAX_EXP
		upgrade_lvl()
		modify_exp(remainder)
	else:
		CURRENT_EXP += amount
	emit_signal("modify_EXP")

func upgrade_lvl():
	CURRENT_EXP = 0
	MAX_EXP *= EXP_MULTIPLIER
	LVL += 1
	CURRENCY_MANAGER.modify_upgrade_points(5)
	emit_signal("modify_lvl")

func apply_buff(dict: Dictionary):
	for i in dict:
		self[i] += dict[i]
	emit_signal("modify_health")
	emit_signal("modify_mana")
