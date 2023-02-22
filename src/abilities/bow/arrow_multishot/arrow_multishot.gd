extends Base_ability

var arrow = load("res://src/attacks/projectiles/arrow/arrow.tscn")

const RANDOM_ANGLE = PI / 2.0
var count = 4
var count_pierce = 0
export (int) var projectile_speed = 200

func _on_arrow_multishot_upgrade(new_lvl):
	match new_lvl:
		1:
			count = 4
		2:
			count = 6
		3:
			count = 8
		4:
			count = 10
		5:
			count = 12
		6:
			count = 14
	lvl = new_lvl

func _on_arrow_multishot_execute(spawn_position, damage, damage_weight):
	for i in count:
		var new_rotation = owner_body.ray_cast.rotation + 0.03 * i if i%2 else owner_body.ray_cast.rotation - 0.03 * i
		var instance: Base_projectile = arrow.instance()
		instance.set_owner_body(owner_body)
		instance.set_count_pierce(count_pierce)
		instance.set_transform(spawn_position)
		instance.set_collisions(owner_body.attack_layer, owner_body.attack_mask)
		instance.set_rotation(new_rotation)
		instance.set_damage(damage, damage_weight)
		instance.set_damage_type(damage_type)
		instance.set_projectile_speed(owner_body.STATS.get_projectile_speed(projectile_speed))
		instance.set_effect_tags(effect_tags)
		get_node("/root").add_child(instance)
	start_cd()
#	Доработать кд скаляцию от скорости атаки!
#	Проверить калькуляцию урона
