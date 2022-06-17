extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite

export (int) var speed = 100
export (int) var damage = 10
export (int) var HP = 100
export (int) var MANA = 50

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	animationPlayer.play("run")
	if Input.is_action_pressed("move_right"):
		sprite.flip_h = false
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		sprite.flip_h = true
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

# Управление мышкой
#var target = null

#func _input(event):
#	if event.is_action_pressed("move_click"):
#		target = get_global_mouse_position()


#func _physics_process(delta):
#	if target:
#		velocity = position.direction_to(target) * speed
#		#look_at(target)
#		if position.distance_to(target) > 5:
#			velocity = move_and_slide(velocity)
#			animationPlayer.play("run")
#
#		if target.x < self.position.x:
#			sprite.flip_h = true
#		elif target.x > self.position.x:
#			sprite.flip_h = false
