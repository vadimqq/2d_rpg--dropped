extends RigidBody2D

onready var animation = $Animation
onready var sprite = $Sprite

var speed = 0
var damage = 0
var knockback_power = 0
var flip_v = false

func _physics_process(delta):
	position += transform.x * speed * delta


func _ready():
	sprite.flip_v = flip_v
	set_as_toplevel(true)
	animation.play("fly")

func fire(new_global_transform, angle):
	transform = new_global_transform
	scale.x = 0.5
	scale.y = 0.5
	rotation = angle

# Столкновение с хитбоксом противника
func _on_hitbox_area_entered(area):
	animation.play("destoy")


# Столкновение с физическими объектами
func _on_hitbox_body_entered(body):
	animation.play("destoy")
