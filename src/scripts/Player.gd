extends "res://src/scripts/body_physics.gd"

onready var animationPlayer = $AnimationPlayer
onready var sprite = $Sprite
onready var weapon = $WeaponSlot/Weapon
onready var weaponSlot = $WeaponSlot
onready var Ui = $Camera2D/Ui
onready var hurt_box = $hurtBox
onready var pick_up_zone = $pick_up_zone/CollisionShape2D

# СКАЛЯЦИЯ НУЖНО БАЛАНСИТЬ
var strength_damage_scale: float = 0.8
var strength_hp_scale: int = 10

var agility_damage_scale: float = 0.5
var agility_attack_speed_scale: float = 0.015
var agility_movement_speed_scale: int = 2


var intellegence_damage_scale: float = 0.2
var intellegence_mana_scale: float = 10

var STAT_PER_LVL = 2

# БАЗОВЫЕ СТАТЫ НУЖНО БАЛАНСИТЬ
export (int) var STRENGTH = 10
export (int) var AGILITY = 10
export (int) var INTELLIGENCE = 10

export (int) var MAX_HP = STRENGTH * strength_hp_scale
export (int) var HP = 100

export (int) var MAX_MANA = INTELLIGENCE * intellegence_mana_scale
export (int) var MANA = 50


export (int) var MAX_EXP = 5
export (int) var EXP = 0
export (float) var EXP_SCALING = 1.4
export (int) var LVL = 1

export (float) var speed = 300 + (AGILITY * agility_movement_speed_scale)
export (float) var damage = (STRENGTH * strength_damage_scale) + (AGILITY * agility_damage_scale) + (INTELLIGENCE * intellegence_damage_scale)
export (float) var attack_speed = 1.2 - (AGILITY * agility_attack_speed_scale)
export (int) var knockback_power = 5
export (float) var pick_up_scailng = 1.9

var skill_sistem = {
	"skill_1": {"cd": 0,"is_cd": false},
	"skill_2": {"cd": 0, "is_cd": false},
	"skill_3": {"cd": 0, "is_cd": false},
	"skill_4": {"cd": 0, "is_cd": false}
} 

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
	get_weapon_skill_info()
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
		DEATH:
			get_tree().change_scene("res://ui/Root_menu.tscn")
	
	if Input.is_action_pressed("attack_click") and attack_cd:
		weapon.attack(weaponSlot.rotation, damage, knockback_power)
		attack_cd = false
		yield(get_tree().create_timer(attack_speed), "timeout")
		attack_cd = true

# SKILL CASTS
func _input(event):
	if event.is_action_pressed("click_skill_1") and !skill_sistem['skill_1']['is_cd']:
		weapon.cast_skill_1(weaponSlot.rotation, damage, knockback_power)
		Ui.start_skill_timer('skill_1')
#------------
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
	if HP <= 0:
		state = DEATH
	else:
		state = TAKE_DAMGE

func lvl_up():
	Ui.upgrade_menu.open_upgrade(self)

func up_STR():
	STRENGTH += STAT_PER_LVL
	updae_stats()
	Ui.load_player_info(self)
	print(STRENGTH)
	print(MAX_HP)

func up_INT():
	INTELLIGENCE += STAT_PER_LVL
	updae_stats()
	Ui.load_player_info(self)

func up_AGI():
	AGILITY += STAT_PER_LVL
	updae_stats()
	Ui.load_player_info(self)


func updae_stats():
	MAX_HP = STRENGTH * strength_hp_scale
	HP = MAX_HP
	MAX_MANA = INTELLIGENCE * intellegence_mana_scale
	MANA = MAX_MANA
	
	speed = 300 + (AGILITY * agility_movement_speed_scale)
	damage = (STRENGTH * strength_damage_scale) + (AGILITY * agility_damage_scale) + (INTELLIGENCE * intellegence_damage_scale)
	attack_speed = 1.2 - (AGILITY * agility_attack_speed_scale)
	MAX_EXP *= EXP_SCALING
	EXP = 0
	LVL += 1

func get_weapon_skill_info():
	skill_sistem['skill_1']['cd'] = weapon.skill_1_cd
	skill_sistem['skill_2']['cd'] = weapon.skill_2_cd
	skill_sistem['skill_3']['cd'] = weapon.skill_3_cd
	skill_sistem['skill_4']['cd'] = weapon.skill_4_cd

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

