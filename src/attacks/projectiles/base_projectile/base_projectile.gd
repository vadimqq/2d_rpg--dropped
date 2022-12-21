extends Base_attack

class_name Base_projectile

onready var sprite = $Sprite

var flip_v = false
var speed = 0

export (int) var count_pierce = 0
export (int) var count_rebound = 0
export (float) var speed_incounter = 1

signal destroy

func _ready():
	sprite.flip_v = flip_v

func _physics_process(delta):
	position += transform.x * (speed * speed_incounter) * delta

func set_count_pierce(amount: int):
	count_pierce = amount

func set_count_rebound(amount: int):
	count_rebound = amount

func set_projectile_speed(amount: int):
	speed = amount

func _on_Area2D_area_entered(area):
	if count_pierce == 0:
		emit_signal("destroy")
	else:
		count_pierce -= 1

func _on_Area2D_body_entered(body):
	if count_rebound > 0:
		if randi() % 2 == 0:
			rotate(-160)
		else:
			rotate(160)
		count_rebound -= 1
	else:
		emit_signal("destroy")
