extends Area2D

onready var animation = $Animation
onready var collison_portal = $CollisionShape2D
# Called when the node enters the scene tree for the first time.

func _ready():
	animation.play("open")

func _on_Position2D_body_entered(body):
	animation.play("close")

func on_close_portal():
	GAME_CORE.up_portal_lvl()
