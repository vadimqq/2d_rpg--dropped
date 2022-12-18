extends Base_ability

class_name Base_togle_ability

onready var collision = $Area2D/CollisionShape2D
onready var area = $Area2D

var is_active = false
var max_size = Vector2(1,1)

signal execute_on
signal execute_of

func _process(delta):
	if is_active && owner_body != null:
		area.global_position = owner_body.global_position
		area.rotation = -owner_body.ray_cast.rotation


func _init():
	type = CONSTANTS.ABILITY_TYPE_ENUM.TOGLE
	
func execute(s: Base_body, spawn_position):
	owner_body = s
	collision.scale = max_size * (s.STATS.get_increase_area() / 100)
	if !is_active:
		is_active = true
		collision.disabled = false
		area.visible = true
		emit_signal("execute_on")
		owner_body.STATS.apply_buff({
			"LOCKED_MANA": mana_cost
		})
	else:
		disable()
	start_cd()

func disable():
	is_active = false
	collision.disabled = true
	area.visible = false
	emit_signal("execute_of")
	owner_body.STATS.apply_buff({
			"LOCKED_MANA": -mana_cost
	})
