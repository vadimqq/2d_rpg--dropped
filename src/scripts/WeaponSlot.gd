extends Node2D


var target = null
onready var sprite = $Sprite
onready var animationWeapon = $AnimationPlayer

func _physics_process(delta):
		target = get_global_mouse_position()	
		look_at(target)
#		if target.x < self.position.x:
#			sprite.flip_h = true
#		elif target.x > self.position.x:
#			sprite.flip_h = false

func _input(event):
	if event.is_action_pressed("attack_click"):
		animationWeapon.play("attack")
		


func end_attack():
	animationWeapon.stop()
