extends "res://src/scripts/body_physics.gd"

var drop = preload("res://src/neutral_Object/Exp_point/Exp_point.tscn")
var flosting_text = preload("res://ui/Floating_text.tscn")
var stats_system = preload('res://src/scripts/stats_system.gd').STAT_SYSTEM

onready var hurt_box = $hurtBox
onready var sprite_pivot = $SpritePivot
onready var hitbox = $hitBox

enum {
	IDLE,
	CHASE,
	DEATH,
	TAKE_DAMAGE,
}

var state = IDLE
var player = null
var stat_instance = null
var can_knockbacked =  true

func _ready():
	start_player_chase(get_tree().get_nodes_in_group('player')[0])

func _physics_process(delta):
	Motion = move_and_slide(Motion)
	match state:
		IDLE:
			state_idle()
		CHASE:
			state_chase()
		DEATH:
			state_death()
		TAKE_DAMAGE:
			state_take_damage(delta)

func create_stat_instance_by_portal_lvl(data):
	var up_data = data.duplicate(true)
	for stat_name in up_data:
		up_data[stat_name] = data[stat_name] + (data[stat_name] / 10) * GAME_CORE.portal_lvl
	stat_instance = stats_system.new(up_data)

func start_player_chase(player_body):
	player = player_body
	state = CHASE

func take_damage(damage):
	var flosting_text_insance = flosting_text.instance()
	flosting_text_insance.amount = damage
	add_child(flosting_text_insance)
	stat_instance.HP -= damage
	if stat_instance.HP <= 0:
		state = DEATH
	else:
		state = TAKE_DAMAGE

func death():
	var drop_instance = drop.instance()
	get_tree().current_scene.add_child(drop_instance)
	drop_instance.transform = transform
	queue_free()

func end_take_damage():
	state = CHASE

func state_idle():
	Motion = Vector2()

func state_chase():
	if player != null:
		Motion = (player.global_position - global_position).normalized() * stat_instance.MOVE_SPEED
		if player.global_position.x > global_position.x:
			sprite_pivot.scale.x = 1
		else:
			sprite_pivot.scale.x = -1

func state_death():
	Motion = Vector2()
	GAME_CORE.enemy_death(global_position)
	hurt_box.monitoring = false
	hurt_box.monitorable = false
#	death()

func state_take_damage(delta):
	if can_knockbacked:
		Motion = Motion.move_toward(Vector2.ZERO, 700 * delta)
		Motion = move_and_slide(Motion)

func _on_hurtBox_area_entered(area):
	Motion = (global_position - area.global_position) * 2
	take_damage(area.damage)
