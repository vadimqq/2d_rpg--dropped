extends Node2D

onready var line =$Line2D
onready var canvas_layer = $CanvasLayer
onready var button_wrapper = $CanvasLayer/HBoxContainer
onready var particle = $Particles2D
onready var area_2d = $Area2D
onready var chest_spawn_position = $Position2D

const void_imp = preload("res://src/enemies/void_imp/void_imp.tscn")
const spawner = preload("res://src/enemies/spawner/spawner.tscn")
const pact_button = preload("res://src/pacts/pact_button_ui.tscn")
const reward_chest = preload("res://src/levels/buildings/chest/chest.tscn")
const TEST = preload("res://src/items/ability_scrolls/arrow_shot/arrow_shot.tscn")

export (Color) var not_cleared_color = "610000"
export (Color) var cleared_color = "5e5e5e"

var spawn_area_size = 100
var count_portal_spawn = 0
var count_enemy_killed = 0

var state = STATE.IDLE
var current_pact = null

enum STATE {
	IDLE,
	PROGRESS,
	FINISH
}

func _ready():
	particle.process_material.color = not_cleared_color
	draw_custom_circle()
	var pacts = PACT_MANAGER.get_random_pacts()
	for pact in pacts:
		var button: TextureButton = pact_button.instance()
		button.hint_tooltip = pact.name
		button_wrapper.add_child(button)
		button.connect("button_up", self, "_on_pact_button_up", [pact])

func draw_custom_circle():
	for i in range(0, 361):
		var angle: float = deg2rad(1.0 * i)
		line.add_point(calc_point_on_circle(angle, 43))

func calc_point_on_circle(angle, radius):
	var s: float = sin(angle)
	var c: float = cos(angle)
	return Vector2(s * radius, c * radius)

func spawn_enemies():
	randomize()
	var spawn_position := global_position
	var instance = spawner.instance()
	instance.spawning_scene = void_imp
	get_parent().add_child(instance)
	instance.global_position = Vector2(
		rand_range(global_position.x - spawn_area_size, global_position.x + spawn_area_size),
		rand_range(global_position.y - spawn_area_size, global_position.y + spawn_area_size)
	)
	count_portal_spawn -= 1
	if count_portal_spawn > 0:
		yield(get_tree().create_timer(get_spawn_time()), "timeout")
		spawn_enemies()

func get_spawn_time():
	var max_t = 3.0
	var min_t = 0.1
	var time = max_t - max_t * (float(PACT_MANAGER.enemy_lvl) / 100)
	if time < 0.1:
		return 0.1
	else:
		return time

func get_player_rewards():
	PACT_MANAGER.disconnect("enemy_killed", self, "on_enemy_killed")
	particle.process_material.color = cleared_color
	current_pact.apply_gift()
	var chest = TEST.instance()
	chest.global_position = chest_spawn_position.global_position
	get_parent().add_child(chest)

func _on_Area2D_body_entered(body):
	canvas_layer.show()

func _on_Area2D_body_exited(body):
	canvas_layer.hide()

func _on_pact_button_up(pact):
	current_pact = pact
	area_2d.monitoring = false
	PACT_MANAGER.connect("enemy_killed", self, "on_enemy_killed")
	current_pact.apply_victim()
	count_portal_spawn = PACT_MANAGER.count_enemy_spawn
	spawn_enemies()
	state = STATE.PROGRESS
	
	canvas_layer.queue_free()

func on_enemy_killed():
	count_enemy_killed += 1
	if count_enemy_killed == PACT_MANAGER.count_enemy_spawn:
		get_player_rewards()
