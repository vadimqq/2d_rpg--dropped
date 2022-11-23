extends Base_DOT

func _init():
	damage = 3.0
	time = 5.0

func _on_bleed_apply_damage(s):
	var damage_value = stack * damage
	var modified_damage = UTILS.get_modified_value_by_percent(damage_value, enemy.STATS.DAMAGE_OVER_TIME)
	s.take_damage(CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC, modified_damage)
