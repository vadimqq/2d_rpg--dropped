extends Base_ability

onready var duration_timer = $duration
onready var ghost_spawn_timer = $ghost_spawn

var dash_ghost = preload("res://src/abilities/dash/dash_ghost.tscn")

var sprite: Sprite

var dash_speed = 300.0
var normal_speed = 0

var dash_time = 0.3

func _init():
	tier = 2
	CD = 2.0
	max_lvl = 3

func add_dash_ghost():
	var ghost_instance = dash_ghost.instance()
	get_node("/root").add_child(ghost_instance)
	
	ghost_instance.global_position = global_position
	ghost_instance.texture = sprite.texture
	ghost_instance.vframes = sprite.vframes
	ghost_instance.hframes = sprite.hframes
	ghost_instance.frame = sprite.frame
	ghost_instance.flip_h = sprite.flip_h

func is_dashing():
	return !duration_timer.is_stopped()

func end_dash():
	ghost_spawn_timer.stop()
	sprite.material.set_shader_param("hit", false)
	owner_body.STATS.apply_buff({
		"GAIN_MOVE_SPEED": -dash_speed
	})
	owner_body.hurtbox_shape.disabled = false

func _on_duration_timeout():
		end_dash()


func _on_ghost_spawn_timeout():
	add_dash_ghost()


func _on_Dash_upgrade(new_lvl):
	match new_lvl:
		1:
			pass
		2:
			pass
		3:
			pass
	lvl = new_lvl


func _on_dash_execute(spawn_position, _1, _2):
	self.sprite = owner_body.sprite
	sprite.material.set_shader_param("mix_weight", 0.7)
	sprite.material.set_shader_param("hit", true)
	owner_body.hurtbox_shape.disabled = true
	owner_body.STATS.apply_buff({
		"GAIN_MOVE_SPEED": dash_speed
	})
	
	duration_timer.wait_time = dash_time
	duration_timer.start()
	ghost_spawn_timer.start()
	start_cd()
