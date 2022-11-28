class STAT_SYSTEM:
	var LVL = 1
#	NON MODIFY STATS:
	var HEALTH = 100.0
	var HEALTH_REGEN = 1.0
	
	var MANA = 50.0
	var MANA_REGEN = 1.0
	
	var MOVE_SPEED = 100.0
	
	var ATTACK_SPEED = 1.0
	var PROJECTILE_SPEED = 300.0
	
	var PHYSIC_DAMAGE = 5.0
	var VOID_DAMAGE = 5.0
	var FIRE_DAMAGE = 5.0
	var NATURE_DAMAGE = 5.0
	
	var CRIT_CHANCE = 10.0
	var CRIT_DAMAGE = 50.0
	
	var VOID_RESIST = 5.0
	var NATURE_RESIST = 5.0
	var LIGHTING_RESIST = 5.0
	var FIRE_RESIST = 5.0
	var PHYSIC_RESIST = 5.0
	
	var CHANCE_BLEED = 0.0
	var CHANCE_POISON = 0.0
	var CHANCE_BURN = 0.0
	
	var BLEED_DAMAGE = 5.0
	var POISON_DAMAGE = 0.0
	var BURN_DAMAGE = 0.0
	
	var CAST_DURATION = 100.0
	var INCREASE_AREA = 100.0
	var CDR = 100.0

#	CURRENT STATS:
	var CURRENT_HEALTH = 0.0
	var CURRENT_MANA = 0.0
	
#	GAIN STATS IN PERCENT:
	var GAIN_HEALTH = 0.0
	var GAIN_HEALTH_REGEN = 0.0
	
	var GAIN_MANA = 0.0
	var GAIN_MANA_REGEN = 0.0
	
	var GAIN_MOVE_SPEED = 0.0
	
	var GAIN_ATTACK_SPEED = 0.0
	var GAIN_PROJECTILE_SPEED = 0.0
	
	var GAIN_DAMAGE = 0.0
	var GAIN_PHYSIC_DAMAGE = 0.0
	var GAIN_VOID_DAMAGE = 0.0
	var GAIN_FIRE_DAMAGE = 0.0
	var GAIN_NATURE_DAMAGE = 0.0
	
	var GAIN_CRIT_CHANCE = 0.0
	var GAIN_CRIT_DAMAGE = 0.0
	
	var GAIN_CAST_DURATION = 0.0
	var GAIN_INCREASE_AREA = 0.0
	var GAIN_CDR = 0.0

	var GAIN_VOID_RESIST = 0.0
	var GAIN_NATURE_RESIST = 0.0
	var GAIN_LIGHTING_RESIST = 0.0
	var GAIN_FIRE_RESIST = 0.0
	var GAIN_PHYSIC_RESIST = 0.0
	
	var GAIN_CHANCE_BLEED = 0.0
	var GAIN_CHANCE_POISON = 0.0
	var GAIN_CHANCE_BURN = 0.0
	
	var GAIN_BLEED_DAMAGE = 0.0
	var GAIN_POISON_DAMAGE = 0.0
	var GAIN_BURN_DAMAGE = 0.0
	
	var GAIN_DAMAGE_OVER_TIME = 0.0
	
#	AMPLIFY STATS IN PERCENT
	var AMPLIFICATION_HEALTH = 0.0
	var AMPLIFICATION_HEALTH_REGEN = 0.0
	
	var AMPLIFICATION_MANA = 0.0
	var AMPLIFICATION_MANA_REGEN = 0.0
	
	var AMPLIFICATION_MOVE_SPEED = 0.0
	
	var AMPLIFICATION_ATTACK_SPEED = 0.0
	var AMPLIFICATION_PROJECTILE_SPEED = 0.0
	
	var AMPLIFICATION_DAMAGE = 0.0
	var AMPLIFICATION_PHYSIC_DAMAGE = 0.0
	var AMPLIFICATION_VOID_DAMAGE = 0.0
	var AMPLIFICATION_FIRE_DAMAGE = 0.0
	var AMPLIFICATION_NATURE_DAMAGE = 0.0
	
	var AMPLIFICATION_CRIT_CHANCE = 0.0
	var AMPLIFICATION_CRIT_DAMAGE = 0.0
	
	var AMPLIFICATION_CAST_DURATION = 0.0
	var AMPLIFICATION_INCREASE_AREA = 0.0

	var AMPLIFICATION_VOID_RESIST = 0.0
	var AMPLIFICATION_NATURE_RESIST = 0.0
	var AMPLIFICATION_LIGHTING_RESIST = 0.0
	var AMPLIFICATION_FIRE_RESIST = 0.0
	var AMPLIFICATION_PHYSIC_RESIST = 0.0
	
	var AMPLIFICATION_CHANCE_BLEED = 0.0
	var AMPLIFICATION_CHANCE_POISON = 0.0
	var AMPLIFICATION_CHANCE_BURN = 0.0
	
	var AMPLIFICATION_BLEED_DAMAGE = 0.0
	var AMPLIFICATION_POISON_DAMAGE = 0.0
	var AMPLIFICATION_BURN_DAMAGE = 0.0
	
	var AMPLIFICATION_DAMAGE_OVER_TIME = 0.0

	func _init():
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

	func get_mana_regen():
		return get_incremented_value(MANA_REGEN, GAIN_MANA_REGEN, AMPLIFICATION_MANA_REGEN)

	func get_move_speed():
		return get_incremented_value(MOVE_SPEED, GAIN_MOVE_SPEED, AMPLIFICATION_MOVE_SPEED)

	func get_attack_speed():
		return get_incremented_value(ATTACK_SPEED, GAIN_ATTACK_SPEED, AMPLIFICATION_ATTACK_SPEED)

	func get_projectile_speed():
		return get_incremented_value(PROJECTILE_SPEED, GAIN_PROJECTILE_SPEED, AMPLIFICATION_PROJECTILE_SPEED)
	
	func get_physic_damage():
		return get_incremented_value(PHYSIC_DAMAGE, GAIN_PHYSIC_DAMAGE + GAIN_DAMAGE, AMPLIFICATION_PHYSIC_DAMAGE + AMPLIFICATION_DAMAGE)
	
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
	
	func get_chance_bleed():
		return get_incremented_value(CHANCE_BLEED, GAIN_CHANCE_BLEED, AMPLIFICATION_CHANCE_BLEED)
	
	func get_chance_poison():
		return get_incremented_value(CHANCE_POISON, GAIN_CHANCE_POISON, AMPLIFICATION_CHANCE_POISON)
	
	func get_chance_burn():
		return get_incremented_value(CHANCE_BURN, GAIN_CHANCE_BURN, AMPLIFICATION_CHANCE_BURN)
	
	func get_bleed_damage():
		return get_incremented_value(BLEED_DAMAGE, GAIN_BLEED_DAMAGE + GAIN_DAMAGE_OVER_TIME, AMPLIFICATION_BLEED_DAMAGE + AMPLIFICATION_DAMAGE_OVER_TIME)
	
	func get_poison_damage():
		return get_incremented_value(POISON_DAMAGE, GAIN_POISON_DAMAGE + GAIN_DAMAGE_OVER_TIME, AMPLIFICATION_POISON_DAMAGE + AMPLIFICATION_DAMAGE_OVER_TIME)
	
	func get_burn_damage():
			return get_incremented_value(BURN_DAMAGE, GAIN_POISON_DAMAGE + GAIN_DAMAGE_OVER_TIME, AMPLIFICATION_BURN_DAMAGE + AMPLIFICATION_DAMAGE_OVER_TIME)

	func get_increase_area():
		return get_incremented_value(INCREASE_AREA, GAIN_INCREASE_AREA, AMPLIFICATION_INCREASE_AREA)

	func get_cdr():
		return CDR - GAIN_CDR

	func get_cd_by_value(value):
		return UTILS.get_value_by_percent(value, get_cdr())

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

	func regen_helth(): 
		if (CURRENT_HEALTH + get_health_regen() < get_max_health()):
			modify_current_health(get_health_regen())
		else:
			CURRENT_HEALTH = get_max_health()

	func modify_current_mana(amount):
		CURRENT_MANA += amount

	func regen_mana(): 
		if (CURRENT_MANA + get_mana_regen() < get_max_mana()):
			modify_current_mana(get_mana_regen())
		else:
			CURRENT_MANA = get_max_mana()

	func upgrade_lvl():
		LVL += 1

	func apply_buff(dict: Dictionary):
		for i in dict:
			self[i] += dict[i]
