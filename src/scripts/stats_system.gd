class STAT_SYSTEM:
	var MAX_HP = 100
	var HP = MAX_HP
	var HP_REG = 1

	var MAX_MANA = 50
	var MANA = MAX_MANA
	var MANA_REG = 1

	var MAX_EXP = 20
	var EXP = 0
	var EXP_SCALING = 1.4
	var LVL = 1

	var BASE_MOVE_SPEED = 200.0
	var BASE_CDR = 0
	var BASE_ATTACK_SPEED = 2.0
	var BASE_PROJECTILE_SPEED = 500.0
	var BASE_CAST_DURATION = 0
	var BASE_INCREASE_AREA = 0
	var BASE_KNOCKBACK_POWER = 0
	var BASE_DAMAGE = 20
	
	var MOVE_SPEED = BASE_MOVE_SPEED
	var CDR = BASE_CDR
	var ATTACK_SPEED = BASE_ATTACK_SPEED
	var PROJECTILE_SPEED = BASE_PROJECTILE_SPEED
	var CAST_DURATION = BASE_CAST_DURATION
	var INCREASE_AREA = BASE_INCREASE_AREA
	var KNOCKBACK_POWER = BASE_KNOCKBACK_POWER
	var DAMAGE = BASE_DAMAGE
	
	#статы для усиления стихий
	var DARK_AMPLIFY = 0
	var WINDOW_AMPLIFY = 0
	var LIGHTING_AMPLIFY = 0
	var FIRE_AMPLIFY = 0

	func _init(speed):
		MOVE_SPEED = speed

	func lvl_up():
		EXP = 0
		MAX_EXP *= EXP_SCALING
		LVL += 1
	
	func up_attack_speed(value):
		ATTACK_SPEED += value

	func up_damge(value):
		DAMAGE += value
