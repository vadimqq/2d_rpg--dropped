class STAT_SYSTEM:

#	NON MODIFY STATS:
	var BASE_HP = 0.0
	var BASE_HP_REG = 0.0
	
	var BASE_MANA = 0.0
	var BASE_MANA_REG = 0.0
	
	var BASE_MOVE_SPEED = 0.0
	var BASE_DASH_TIME = 0.0
	
	var BASE_ATTACK_SPEED = 0.0
	var BASE_PROJECTILE_SPEED = 0.0
	var BASE_DAMAGE = 0.0
	
	var BASE_CRIT_CHANCE = 10.0
	var BASE_CRIT_DAMAGE = 50.0
	
	var BASE_CAST_DURATION = 0.0
	var BASE_INCREASE_AREA = 0.0
	var BASE_KNOCKBACK_POWER = 0.0
	var BASE_CDR = 0.0

	var BASE_DAMAGE_OVER_TIME = 0.0


#	MAX_STATS:
	var MAX_HP = 0.0
	var MAX_HP_REG = 0.0
	
	var MAX_MANA = 0.0
	var MAX_MANA_REG = 0.0
	
	var MAX_MOVE_SPEED = 0.0
	var MAX_DASH_TIME = 0.0
	
	var MAX_ATTACK_SPEED = 0.0
	var MAX_PROJECTILE_SPEED = 0.0
	var MAX_DAMAGE = 0.0
	
	var MAX_CRIT_CHANCE = 0.0
	var MAX_CRIT_DAMAGE = 0.0
	
	var MAX_CAST_DURATION = 0.0
	var MAX_INCREASE_AREA = 0.0
	var MAX_KNOCKBACK_POWER = 0.0
	var MAX_CDR = 0.0
	
	var MAX_DAMAGE_OVER_TIME = 0.0

#	CURRENT STATS:
	var HP = 0.0
	var HP_REG = 0.0
	
	var MANA = 0.0
	var MANA_REG = 0.0
	
	var MOVE_SPEED = 0.0
	var DASH_TIME = 0.0
	
	var ATTACK_SPEED = 0.0
	var PROJECTILE_SPEED = 0.0
	var DAMAGE = 0.0
	
	var CRIT_CHANCE = 0.0
	var CRIT_DAMAGE = 0.0
	
	var CAST_DURATION = 0.0
	var INCREASE_AREA = 0.0
	var KNOCKBACK_POWER = 0.0
	var CDR = 0.0


	#статы для усиления стихий
	var DARK_AMPLIFY = 0
	var WINDOW_AMPLIFY = 0
	var LIGHTING_AMPLIFY = 0
	var FIRE_AMPLIFY = 0
	var PHYSIC_AMPLIFY = 0


	#резисты стихий
	var DARK_RESIST = 0
	var WINDOW_RESIST = 0
	var LIGHTING_RESIST = 0
	var FIRE_RESIST = 0
	var PHYSIC_RESIST = 0

	#ПРОКИ ДЛЯ DOT
	var CHANCE_BLEED = 0.0
	var CHANCE_POISION = 0.0
	var CHANCE_BURN = 0.0
	
	var DAMAGE_OVER_TIME = 0.0

	var MAX_EXP = 50
	var EXP = 0
	var EXP_SCALING = 1.1
	var LVL = 1


	func _init(dict: Dictionary):
		LVL = dict['LVL'] if dict.has('LVL') else 1
		
		BASE_HP = dict['HP'] if dict.has('HP') else BASE_HP
		BASE_HP_REG = dict['HP_REG'] if dict.has('HP_REG') else BASE_HP_REG
		
		BASE_MANA = dict['MANA'] if dict.has('MANA') else BASE_MANA
		BASE_MANA_REG = dict['MANA_REG'] if dict.has('MANA_REG') else BASE_MANA_REG
		
		BASE_MOVE_SPEED = dict['MOVE_SPEED'] if dict.has('MOVE_SPEED') else BASE_MOVE_SPEED
		BASE_DASH_TIME = dict['DASH_TIME'] if dict.has('DASH_TIME') else BASE_DASH_TIME
		
		BASE_ATTACK_SPEED = dict['ATTACK_SPEED'] if dict.has('ATTACK_SPEED') else BASE_ATTACK_SPEED
		BASE_PROJECTILE_SPEED = dict['PROJECTILE_SPEED'] if dict.has('PROJECTILE_SPEED') else BASE_PROJECTILE_SPEED
		BASE_DAMAGE = dict['DAMAGE'] if dict.has('DAMAGE') else BASE_DAMAGE
		
		BASE_CRIT_CHANCE = dict['CRIT_CHANCE'] if dict.has('CRIT_CHANCE') else BASE_CRIT_CHANCE
		BASE_CRIT_DAMAGE = dict['CRIT_DAMAGE'] if dict.has('CRIT_DAMAGE') else BASE_CRIT_DAMAGE
		
		BASE_CAST_DURATION = dict['CAST_DURATION'] if dict.has('CAST_DURATION') else BASE_CAST_DURATION
		BASE_INCREASE_AREA = dict['INCREASE_AREA'] if dict.has('INCREASE_AREA') else BASE_INCREASE_AREA
		BASE_KNOCKBACK_POWER = dict['KNOCKBACK_POWER'] if dict.has('KNOCKBACK_POWER') else BASE_KNOCKBACK_POWER
		BASE_CDR = dict['CDR'] if dict.has('CDR') else BASE_CDR

#		INIT MAX STATS
		MAX_HP = BASE_HP
		MAX_HP_REG = BASE_HP_REG
		MAX_MANA = BASE_MANA
		MAX_MANA_REG = BASE_MANA_REG
		MAX_MOVE_SPEED = BASE_MOVE_SPEED
		MAX_DASH_TIME = BASE_DASH_TIME
		MAX_ATTACK_SPEED = BASE_ATTACK_SPEED
		MAX_PROJECTILE_SPEED = BASE_PROJECTILE_SPEED
		MAX_DAMAGE = BASE_DAMAGE
		MAX_CRIT_CHANCE = BASE_CRIT_CHANCE
		MAX_CRIT_DAMAGE = BASE_CRIT_DAMAGE
		MAX_CAST_DURATION = BASE_CAST_DURATION
		MAX_INCREASE_AREA = BASE_INCREASE_AREA
		MAX_KNOCKBACK_POWER = BASE_KNOCKBACK_POWER
		MAX_CDR = BASE_CDR


#		INIT CURRENT STATS
		HP = BASE_HP
		HP_REG = BASE_HP_REG
		MANA = BASE_MANA
		MANA_REG = BASE_MANA_REG
		MOVE_SPEED = BASE_MOVE_SPEED
		DASH_TIME = BASE_DASH_TIME
		ATTACK_SPEED = BASE_ATTACK_SPEED
		PROJECTILE_SPEED = BASE_PROJECTILE_SPEED
		DAMAGE = BASE_DAMAGE
		CRIT_CHANCE = BASE_CRIT_CHANCE
		CRIT_DAMAGE = BASE_CRIT_DAMAGE
		CAST_DURATION = BASE_CAST_DURATION
		INCREASE_AREA = BASE_INCREASE_AREA
		KNOCKBACK_POWER = BASE_KNOCKBACK_POWER
		CDR = BASE_CDR

	func lvl_up(residue_exp):
		EXP = residue_exp
		MAX_EXP *= EXP_SCALING
		LVL += 1
	
	func modify_attack_speed(amount):
		ATTACK_SPEED += amount

	func modify_damage(amount):
		DAMAGE += amount
	
	func modify_lightning_amplify(amount):
		LIGHTING_AMPLIFY += amount
	
	func modify_dark_amplify(amount):
		DARK_AMPLIFY += amount

	func modify_bleed_chance(amount):
		CHANCE_BLEED += amount

	func modify_poision_chance(amount):
		CHANCE_POISION += amount

	func modify_burn_chance(amount):
		CHANCE_BURN += amount

	func modify_health(amount):
		HP += amount

	func regen_helth(): 
		if (HP <= MAX_HP):
			modify_health(HP_REG)
		else:
			HP = MAX_HP

	func modify_mana(amount):
		MANA += amount

	func regen_mana(): 
		if (MANA <= MAX_MANA):
			modify_mana(MANA_REG)
		else:
			MANA = MAX_MANA

	func apply_damage_and_return(type, amount: int):
		var applied_damage = 0
		if(type == CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC):
			applied_damage = amount - (amount / 100 * PHYSIC_RESIST)
		elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.DARK):
			applied_damage = amount - (amount / 100 * DARK_RESIST)
		elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.FIRE):
			applied_damage = amount - (amount / 100 * FIRE_RESIST)
		elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.LIGHTING):
			applied_damage = amount - (amount / 100 * LIGHTING_RESIST)
		elif(type == CONSTANTS.DAMAGE_TYPE_ENUM.WINDOW):
			applied_damage = amount - (amount / 100 * WINDOW_RESIST)
	
		modify_health(-applied_damage)
		return applied_damage

	func apply_buff(dict: Dictionary):
		if dict.has("HP"):
			HP += BASE_HP / 100 * dict.HP
		if dict.has("BASE_HP_REG"):
			HP_REG += BASE_HP_REG / 100 * dict.HP_REG
		if dict.has("MANA"):
			MANA += BASE_MANA / 100 * dict.MANA
		if dict.has("MANA_REG"):
			MANA_REG += BASE_MANA_REG / 100 * dict.MANA_REG
		if dict.has("MOVE_SPEED"):
			MOVE_SPEED += BASE_MOVE_SPEED / 100 * dict.MOVE_SPEED
		if dict.has("DASH_TIME"):
			DASH_TIME += BASE_DASH_TIME / 100 * dict.DASH_TIME
		if dict.has("ATTACK_SPEED"):
			ATTACK_SPEED += BASE_ATTACK_SPEED / 100 * dict.ATTACK_SPEED
		if dict.has("PROJECTILE_SPEED"):
			PROJECTILE_SPEED += BASE_PROJECTILE_SPEED / 100 * dict.PROJECTILE_SPEED
		if dict.has("DAMAGE"):
			DAMAGE += BASE_DAMAGE / 100 * dict.DAMAGE
		if dict.has("CRIT_CHANCE"):
			CRIT_CHANCE += dict.CRIT_CHANCE
		if dict.has("CRIT_DAMAGE"):
			CRIT_DAMAGE += dict.CRIT_DAMAGE
		if dict.has("CAST_DURATION"):
			CAST_DURATION += BASE_CAST_DURATION / 100 * dict.CAST_DURATION
		if dict.has("INCREASE_AREA"):
			INCREASE_AREA += dict.INCREASE_AREA
		if dict.has("KNOCKBACK_POWER"):
			KNOCKBACK_POWER += BASE_KNOCKBACK_POWER / 100 * dict.KNOCKBACK_POWER
		if dict.has("CDR"):
			CDR += dict.CDR


		if dict.has("DARK_AMPLIFY"):
			DARK_AMPLIFY += dict.DARK_AMPLIFY
		if dict.has("WINDOW_AMPLIFY"):
			WINDOW_AMPLIFY += dict.WINDOW_AMPLIFY
		if dict.has("LIGHTING_AMPLIFY"):
			LIGHTING_AMPLIFY += dict.LIGHTING_AMPLIFY
		if dict.has("FIRE_AMPLIFY"):
			FIRE_AMPLIFY += dict.FIRE_AMPLIFY
		if dict.has("PHYSIC_AMPLIFY"):
			PHYSIC_AMPLIFY += dict.PHYSIC_AMPLIFY


		if dict.has("DARK_RESIST"):
			DARK_RESIST += dict.DARK_RESIST
		if dict.has("WINDOW_RESIST"):
			WINDOW_RESIST += dict.WINDOW_RESIST
		if dict.has("LIGHTING_RESIST"):
			LIGHTING_RESIST += dict.LIGHTING_RESIST
		if dict.has("FIRE_RESIST"):
			FIRE_RESIST += dict.FIRE_RESIST
		if dict.has("PHYSIC_RESIST"):
			PHYSIC_RESIST += dict.PHYSIC_RESIST

	func get_percent_attack_speed(amount):
		return MAX_ATTACK_SPEED / 100 * amount
