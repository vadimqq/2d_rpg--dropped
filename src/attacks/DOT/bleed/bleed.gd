extends Base_DOT

func _on_bleed_apply_damage():
	var damage_value = owner_body.STATS.get_bleed_damage(damage) * stack
	target_body.take_damage(CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC, damage_value)
