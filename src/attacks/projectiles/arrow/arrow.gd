extends Base_projectile

onready var animation = $Animation
onready var trail = $Trail
onready var trail_postion = $Trail_postion

export (int) var trail_length = 100
var point = Vector2.ZERO

var fire_color = "#de4515"
var physic_color = "#ffffff"

func _ready():
	match damage_type:
		CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC:
			modulate = physic_color
		CONSTANTS.DAMAGE_TYPE_ENUM.FIRE:
			modulate = fire_color
	animation.play("fly")

func _process(delta):
	trail.global_position = Vector2.ZERO
	trail.global_rotation = 0
	point = trail_postion.global_position
	trail.add_point(point)
	
	while trail.get_point_count() > trail_length:
		trail.remove_point(0)

func _on_arrow_destroy():
	queue_free()
