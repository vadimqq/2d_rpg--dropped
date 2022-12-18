extends Node2D

onready var progress = $TextureProgress
onready var spawn_position = $Position2D
onready var line: Line2D = $Line2D

export(int) var time

var is_active = false
var max_time: float = 5.0
var current_time: float = 0.0

func _ready():
	draw_custom_circle()

func _physics_process(delta):
	progress.value = 100 * current_time / max_time

func _on_PlayerDetectionZone_body_entered(body):
	is_active = true
	inc_time()

func _on_PlayerDetectionZone_body_exited(body):
	is_active = false
	dec_time()

func inc_time():
	current_time += 0.1
	yield(get_tree().create_timer(0.1), "timeout")
	if is_active && max_time > current_time:
		inc_time()

func dec_time():
	current_time -= 0.1
	yield(get_tree().create_timer(0.1), "timeout")
	if !is_active && current_time > 0:
		dec_time()

func draw_custom_circle():
	for i in range(0, 361):
		var angle: float = deg2rad(1.0 * i)
		line.add_point(calc_point_on_circle(angle, 81))

func calc_point_on_circle(angle, radius):
	var s: float = sin(angle)
	var c: float = cos(angle)
	return Vector2(s * radius, c * radius)


func _on_TextureProgress_value_changed(value):
	if value == 100:
		var item = OBJECT_MANAGER.get_randomize_item()
		get_tree().get_current_scene().y_sort.add_child(item)
		item.global_position = spawn_position.global_position
		line.clear_points()
		set_physics_process(false)
		max_time = 0
		current_time = 0
