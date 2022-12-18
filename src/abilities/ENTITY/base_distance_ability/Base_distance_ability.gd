extends Base_ability

class_name Base_distance_ability

onready var projectile = load("res://src/abilities/ENTITY/base_distance_ability/spawner.tscn")
onready var tween = $Tween

export(Texture) var texture

signal execute
export var duration = 0.5
export var step_time = 0.1
export var max_size = Vector2(3,3)

func execute(s: Base_body, spawn_position):
	owner_body = s
	var instance: Base_projectile = projectile.instance()
	instance.duration = duration * (owner_body.STATS.get_cast_duration() / 100)
	instance.load_info(s, spawn_position, s.ray_cast.rotation, damage_tags, 0 )
	instance.speed = s.STATS.get_projectile_speed() / 2
	get_node("/root").add_child(instance)
	instance.sprite.texture = texture
	instance.one_step_timer.wait_time = step_time
	
	emit_signal("execute", instance)
