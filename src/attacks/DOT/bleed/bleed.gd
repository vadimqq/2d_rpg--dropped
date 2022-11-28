extends Base_DOT

func _init():
	time = 5.0

func _on_bleed_apply_damage(s):
	var damage_value = enemy.STATS.get_bleed_damage() * stack
	s.take_damage(CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC, damage_value)
