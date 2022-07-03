extends Area2D

var lightning_chain = preload("res://src/skills/lightning/lightning_chain/lightning_chain.tscn")

onready var animation = $Animation
onready var sprite = $Sprite

var speed = 0
var damage = 0
var knockback_power = 0
var flip_v = false

var can_cast_ligtning_chain = false
var ligtning_chain_damage = 0

func _physics_process(delta):
	position += transform.x * speed * delta


func _ready():
	sprite.flip_v = flip_v
	set_as_toplevel(true)
	animation.play("fly")

func fire(new_global_transform, angle, projectile_damage, projectile_speed):
	damage = projectile_damage
	speed = projectile_speed
	transform = new_global_transform
	rotation = angle

func cast_lightnining_chain(area):
	var lightning_chain_instance = lightning_chain.instance()
	lightning_chain_instance.damage = ligtning_chain_damage
#	добавляю в противника ноду надо переделать!!!
	area.call_deferred("add_child", lightning_chain_instance)

func _on_Node2D_area_entered(area):
	if can_cast_ligtning_chain:
		cast_lightnining_chain(area)
	call_deferred('free')


func _on_Node2D_body_entered(body):
	queue_free()
