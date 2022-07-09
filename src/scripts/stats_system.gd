class STAT_SYSTEM:
	var MAX_HP = 100
	var HP = MAX_HP
	var HP_REG = 1

	var MAX_EXP = 50
	var EXP = 0
	var EXP_SCALING = 1.1
	var LVL = 1

	var BASE_MOVE_SPEED = 300.0
	var BASE_DASH_SPEED = 600.0
	var BASE_ATTACK_SPEED = 2.0
	var BASE_PROJECTILE_SPEED = 500.0
	var BASE_CAST_DURATION = 100
	var BASE_INCREASE_AREA = 0
	var BASE_KNOCKBACK_POWER = 0
	var BASE_DAMAGE = 20.0
	
	var MOVE_SPEED = 0
	var DASH_SPEED = 0
	var CDR = 0
	var ATTACK_SPEED = 0
	var PROJECTILE_SPEED = 0
	var CAST_DURATION = 0
	var INCREASE_AREA = 0
	var KNOCKBACK_POWER = 0
	var DAMAGE = 0
	
	#статы для усиления стихий
	var DARK_AMPLIFY = 0
	var WINDOW_AMPLIFY = 0
	var LIGHTING_AMPLIFY = 0
	var FIRE_AMPLIFY = 0
	
	#резисты стихий
	var DARK_RESIST = 0
	var WINDOW_RESIST = 0
	var LIGHTING_RESIST = 0
	var FIRE_RESIST = 0

	func _init(dict):
		MAX_HP = dict['MAX_HP']
		LVL = dict['LVL']
#		BASE_MOVE_SPEED = dict['BASE_MOVE_SPEED']
#		BASE_DASH_SPEED = dict['BASE_DASH_SPEED']
#		BASE_ATTACK_SPEED = dict['BASE_ATTACK_SPEED']
#		BASE_PROJECTILE_SPEED = dict['BASE_PROJECTILE_SPEED']
#		BASE_CAST_DURATION = dict['BASE_CAST_DURATION']
#		BASE_INCREASE_AREA = dict['BASE_INCREASE_AREA']
#		BASE_DAMAGE = dict['BASE_DAMAGE']
		DARK_AMPLIFY = dict['DARK_AMPLIFY']
		WINDOW_AMPLIFY = dict['WINDOW_AMPLIFY']
		LIGHTING_AMPLIFY = dict['LIGHTING_AMPLIFY']
		FIRE_AMPLIFY = dict['FIRE_AMPLIFY']
		DARK_RESIST = dict['DARK_RESIST']
		WINDOW_RESIST = dict['WINDOW_RESIST']
		LIGHTING_RESIST = dict['LIGHTING_RESIST']
		FIRE_RESIST = dict['FIRE_RESIST']
		
		MOVE_SPEED = dict['MOVE_SPEED']
		DASH_SPEED = dict['DASH_SPEED']
		CDR = dict['CDR']
		ATTACK_SPEED = dict['ATTACK_SPEED']
		PROJECTILE_SPEED = dict['PROJECTILE_SPEED']
		CAST_DURATION = dict['CAST_DURATION']
		INCREASE_AREA = dict['INCREASE_AREA']
		DAMAGE = dict['DAMAGE']
		HP = dict['MAX_HP']

	func lvl_up(residue_exp):
		EXP = residue_exp
		MAX_EXP *= EXP_SCALING
		LVL += 1
	
	func up_attack_speed(value):
		ATTACK_SPEED += value

	func up_damage(value):
		DAMAGE += value
	
	func up_lightning_amplify(value):
		LIGHTING_AMPLIFY += value
	
	func up_dark_amplify(value):
		DARK_AMPLIFY += value

# для метты кдр, дубликатор, 
