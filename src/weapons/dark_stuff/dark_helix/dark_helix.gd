extends Node2D

onready var animation = $Animation
onready var sprite = $Sprite

var speed = 0
var damage = 0
var knockback_power = 0
var flip_h = false

func _ready():
	sprite.flip_h = flip_h
	set_as_toplevel(true)
	animation.play("cast")
