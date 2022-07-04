extends Area2D

onready var animation = $Animation
onready var detection_zone = $Enemy_detection_zone/CollisionShape2D
onready var sprite = $Sprite

var count = 4
var damage = 0
var enemy_colliding_array = []
var enemy_position = null

func _ready():
	detection_zone.scale.x = 0
	detection_zone.scale.y = 0
	animation.play("find")

func change_position():
	global_position = enemy_position
	animation.play("find")


func _on_Enemy_detection_zone_body_entered(body):
	if !enemy_colliding_array.has(body):
		animation.stop()
		look_at(body.global_position)
		var distance = global_position.distance_to(body.global_position)
		var sprite_region_rect = sprite.region_rect
		sprite_region_rect.size.x = distance
		sprite.flip_h = bool(randi() % 2)
		animation.get_animation('cast').track_set_key_value(0, 1, sprite_region_rect)
		animation.play('cast')

		enemy_position = body.global_position
		enemy_colliding_array.push_back(body)
