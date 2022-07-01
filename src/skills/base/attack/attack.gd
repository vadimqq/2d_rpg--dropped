extends Area2D


onready var animation = $Animation
onready var sprite = $Sprite

var speed = 0
var damage = 0
var knockback_power = 0

func _ready():
	set_as_toplevel(true)
	animation.play("cast")
