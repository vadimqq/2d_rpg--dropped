extends "res://src/scripts/body_physics.gd"

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var weapon = $WeaponSlot/Weapon
onready var weaponSlot = $WeaponSlot

export (int) var speed = 100
export (int) var damage = 10
export (int) var HP = 100
export (int) var MANA = 50
export (int) var attack_speed = 0.5

enum {
	IDLE,
	MOVE,
	DEATH,
	DASH
}

var state = IDLE
var attack_cd = true


func _physics_process(delta):
	Motion = move_and_slide(Motion)
	
	match state:
		IDLE:
			state_idle()
		MOVE:
			state_move()

func _input(event):
	if event.is_action_pressed("attack_click") and attack_cd:
		weapon.attack(weaponSlot.rotation_degrees, weaponSlot.rotation, damage)
		attack_cd = false
		yield(get_tree().create_timer(attack_speed), "timeout")
		attack_cd = true


func state_idle():
	animationPlayer.play("idle")
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left") || Input.is_action_pressed("move_down") || Input.is_action_pressed("move_up"):
		state = MOVE

func state_move():
	Motion = Vector2()
	animationPlayer.play("run")
	if Input.is_action_pressed("move_right"):
		sprite.flip_h = false
		_MotionRight()
	if Input.is_action_pressed("move_left"):
		sprite.flip_h = true
		_MotionLeft()
	if Input.is_action_pressed("move_down"):
		_MotionDown()
	if Input.is_action_pressed("move_up"):
		_MotionUp()
	if Motion == Vector2(0,0):
		state = IDLE
		
	Motion = Motion.normalized() * speed
