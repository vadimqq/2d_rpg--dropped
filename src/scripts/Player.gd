extends "res://src/scripts/body_physics.gd"

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var weapon = $WeaponSlot/Weapon
onready var weaponSlot = $WeaponSlot
onready var Ui = $Camera2D/Ui
onready var hurt_box = $hurtBox
onready var pick_up_zone = $pick_up_zone/CollisionShape2D


export (int) var MAX_HP = 100
export (int) var HP = 100

export (int) var MAX_MANA = 100
export (int) var MANA = 50

export (int) var MAX_EXP = 5
export (int) var EXP = 0
export (float) var EXP_SCALING = 1.4
export (int) var LVL = 1

export (float) var speed = 300
export (float) var damage = 10
export (float) var attack_speed = 1.2
export (int) var knockback_power = 5
export (float) var pick_up_scailng = 1.9

var take_damage_time = 0.5
var invulnerability_time = 1

enum {
	IDLE,
	MOVE,
	DEATH,
	DASH,
	TAKE_DAMGE
}

var state = IDLE
var attack_cd = true

func _ready():
	Ui.load_player_info(self)
	pick_up_zone.scale.x = pick_up_scailng
	pick_up_zone.scale.y = pick_up_scailng

func _physics_process(delta):
	Motion = move_and_slide(Motion)
	
	if MAX_EXP <= EXP:
		lvl_up()

	match state:
		IDLE:
			state_idle()
		MOVE:
			state_move()
		TAKE_DAMGE:
			state_take_damage()
	
	if Input.is_action_pressed("attack_click") and attack_cd:
		weapon.attack(weaponSlot.rotation, damage, knockback_power)
		attack_cd = false
		yield(get_tree().create_timer(attack_speed), "timeout")
		attack_cd = true

func _input(event):
	if event.is_action_pressed("click_skill_1"):
		weapon.cast_skill_1(weaponSlot.rotation, damage, knockback_power)

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

func state_take_damage():
	animationPlayer.play("take_damage")
	sprite.material.set_shader_param('whiten', true)
	yield(get_tree().create_timer(take_damage_time), "timeout")
	sprite.material.set_shader_param('whiten', false)
	state = MOVE

func take_damage(damage):
	HP -= damage
	state = TAKE_DAMGE

func lvl_up():
	LVL += 1
	EXP = 0
	MAX_EXP *= EXP_SCALING
	speed += 10
	damage += 10
	attack_speed -= 0.1
	Ui.load_player_info(self)

# получение урона
func _on_hurtBox_area_entered(area):
	var enemy = area.get_parent()
	hurt_box.set_block_signals(true)
	take_damage(enemy.damage)
	yield(get_tree().create_timer(invulnerability_time), "timeout")
	hurt_box.set_block_signals(false)

# подбор эекспы
func _on_pick_up_zone_body_entered(body):
	body.pick_up(self)
