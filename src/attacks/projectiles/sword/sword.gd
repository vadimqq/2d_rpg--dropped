extends Base_projectile

func _ready():
	type = CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC
	check_crit_chance(crit_chance, crit_damage)
