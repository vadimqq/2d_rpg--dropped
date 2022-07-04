extends Area2D

onready var animation = $Animation
onready var sprite = $Sprite
onready var collider = $CollisionShape2D

var speed = 0
var damage = 0
var knockback_power = 0
var flip_v = false

func _physics_process(delta):
	position += transform.x * speed * delta


func _ready():
	sprite.flip_v = flip_v
	set_as_toplevel(true)
	animation.play("idle")

func fire(new_global_transform, angle, projectile_damage, projectile_speed):
	damage = projectile_damage
	speed = projectile_speed
	transform = new_global_transform
	rotation = angle


func _on_Dark_ball_area_entered(area):
	queue_free()


func _on_Dark_ball_body_entered(body):
	queue_free()
