extends Node2D


onready var hitbox = $Hitbox
onready var animation = $Animation



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attack():
	hitbox.visible = true
	animation.play("attack")


func end_attack():
#	hitbox.visible = false
	animation.stop()
	
