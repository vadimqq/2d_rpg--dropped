extends Base_ability

var fireball = load("res://src/attacks/projectiles/fireball/fireball.tscn")

export (int) var count_pierce = 0
export (int) var count_rebound = 0
export (int) var projectile_speed = 100

func _on_arrow_shot_execute(spawn_position, damage, damage_weight):
	var instance: Base_projectile = fireball.instance()
	instance.set_count_pierce(count_pierce)
	instance.set_count_rebound(count_rebound)
	instance.set_transform(spawn_position)
	instance.set_collisions(owner_body.attack_layer, owner_body.attack_mask)
	instance.set_rotation(owner_body.ray_cast.rotation)
	instance.set_damage(damage, damage_weight)
	instance.set_damage_type(damage_type)
	instance.set_projectile_speed(owner_body.STATS.get_projectile_speed(projectile_speed))
	instance.set_effect_tags(effect_tags)
	get_node("/root").add_child(instance)
	
	CD = owner_body.STATS.get_attack_speed()
	start_cd()

func _on_fireball_shot_upgrade(new_lvl):
	match new_lvl:
		2:
			pass
	lvl = new_lvl
