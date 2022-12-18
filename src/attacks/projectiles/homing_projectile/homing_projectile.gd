extends Base_attack

class_name Homing_projectile

export var lifetime := 20.0

export var drag_factor := 0.05

var target: Base_body

var current_velocity := Vector2.ZERO

onready var sprite := $Sprite

onready var enemy_detector := $Enemy_detector

func _ready():
	enemy_detector.collision_layer = owner_body.enemy_body_layer
	var timer := get_tree().create_timer(lifetime)
	timer.connect("timeout", self, "queue_free")
	
	current_velocity = speed * Vector2.RIGHT.rotated(rotation)

func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation).normalized()
	
	if target:
		direction = global_position.direction_to(target.global_position)

	var desired_velocity := direction * speed
	var previous_velocity = current_velocity
	var change = (desired_velocity - current_velocity) * drag_factor
	
	current_velocity += change
	
	position += current_velocity * delta
	look_at(global_position + current_velocity)

func set_drag_factor(new_value: float) -> void:
	drag_factor = clamp(new_value, 0.01, 0.5)

func _on_homing_projectile_area_entered(area):
	queue_free()

func _on_Enemy_detector_body_entered(enemy: Base_body):
	if target != null:
		return
		
	if enemy == null:
		return
		
	target = enemy

func _on_Enemy_detector_body_exited(body):
	target = null
