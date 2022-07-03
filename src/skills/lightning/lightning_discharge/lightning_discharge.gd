extends Area2D

onready var animation = $Animation
onready var sprite = $Sprite

var damage = 0
var flip_v = false

func _ready():
	set_as_toplevel(true)
	animation.play("cast")
