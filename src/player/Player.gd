extends "res://src/scripts/body_physics.gd"

onready var animationNode = $AnimationNode
onready var sprite = $AnimationNode/sprite
onready var animationPlayer = $AnimationNode/AnimationPlayer
onready var muzzle = $Muzzle
onready var muzzle_spawn = $Muzzle/Spawn_position
onready var Ui = $CanvasLayer/Ui
onready var spirit_pivot = $Spirts_pivot
onready var dash_pivot = $AnimationNode/Dash_pivot
onready var hurt_box = $HurtBox/CollisionShape2D

var stats_system = preload('res://src/scripts/stats_system.gd').STAT_SYSTEM
var base_attack = preload("res://src/skills/base/attack/attack.tscn")
var dash_effect = preload("res://src/effects/dash/dash.tscn")

var stats_instance = null
var can_cast_dash = true

enum {
	IDLE,
	MOVE,
	DEATH,
	CAST,
	DASH
}

var state = IDLE

func _ready():
	stats_instance = stats_system.new(player_data)
	Ui.load_player_info(stats_instance)
	Ui.open_upgrade_menu(spirit_pivot)

func _physics_process(delta):
	muzzle.look_at(get_global_mouse_position())
	Motion = move_and_slide(Motion)
	match state:
		IDLE:
			state_idle()
		MOVE:
			state_move()
		DEATH:
			state_death()
		CAST:
			state_cast()
		DASH:
			state_dash()

	if Input.is_action_pressed("attack_click") and state != CAST and state != DASH:
		state = CAST
		animationPlayer.play("base_attack")
	if Input.is_action_pressed("dash") and can_cast_dash:
		var dash_instance = dash_effect.instance()
		get_tree().current_scene.add_child(dash_instance)
		dash_instance.global_position = dash_pivot.global_position
		dash_instance.scale.x = animationNode.scale.x
		state = DASH
		
		can_cast_dash = false
		yield(get_tree().create_timer(1), "timeout")
		can_cast_dash = true


func state_idle():
	Motion = Vector2()
	animationPlayer.play("idle")
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left") || Input.is_action_pressed("move_down") || Input.is_action_pressed("move_up"):
		state = MOVE

func state_move():
	Motion = Vector2()
	
	if Input.is_action_pressed("move_right"):
		animationNode.scale.x = 1
		_MotionRight()
	if Input.is_action_pressed("move_left"):
		animationNode.scale.x = -1
		_MotionLeft()
	if Input.is_action_pressed("move_down"):
		_MotionDown()
	if Input.is_action_pressed("move_up"):
		_MotionUp()
	if Motion == Vector2(0,0):
		state = IDLE
	else:
		animationPlayer.play("run")
	Motion = Motion.normalized() * stats_instance.MOVE_SPEED

func state_dash():
#	доделать состояние рывка
	Motion = Vector2()
	animationPlayer.play("dash")
	if Input.is_action_pressed("move_right"):
		animationNode.scale.x = 1
		_MotionRight()
	if Input.is_action_pressed("move_left"):
		animationNode.scale.x = -1
		_MotionLeft()
	if Input.is_action_pressed("move_down"):
		_MotionDown()
	if Input.is_action_pressed("move_up"):
		_MotionUp()
	if Motion == Vector2():
		if animationNode.scale.x == 1:
			_MotionRight()
		else:
			_MotionLeft()
	Motion = Motion * stats_instance.DASH_SPEED

func state_cast():
	animationPlayer.playback_speed = stats_instance.ATTACK_SPEED
	if global_position.x > get_global_mouse_position().x:
		animationNode.scale.x = -1
	else:
		animationNode.scale.x = 1
	Motion = Vector2()

func state_death():
	Motion = Vector2()
	animationPlayer.playback_speed = 0.5
	animationPlayer.play("death")

func take_damage(damage):
	if stats_instance.HP - damage <= 0:
		state = DEATH
	stats_instance.HP -= damage

	hurt_box.scale.x = 0
	hurt_box.scale.y = 0
	sprite.material.set_shader_param('whiten', true)
	yield(get_tree().create_timer(0.5), "timeout")
	sprite.material.set_shader_param('whiten', false)
	hurt_box.scale.x = 1
	hurt_box.scale.y = 1
	

func take_EXP(value):
	if (stats_instance.EXP + value) >= stats_instance.MAX_EXP:
		var residue_exp = (stats_instance.EXP + value) - stats_instance.MAX_EXP
		lvl_up(residue_exp)
	else:
		stats_instance.EXP += value

func lvl_up(residue_exp):
	Ui.open_upgrade_menu(spirit_pivot)
	stats_instance.lvl_up(residue_exp)
	Ui.load_player_info(stats_instance)

func upgrade_spirit(link):
	var spirit_instance = load(link).instance()
	spirit_instance.stats_instance = stats_instance
	spirit_pivot.add_new_spirit(spirit_instance)

func end_cast():
	animationPlayer.playback_speed = 1
	state = IDLE

func cast_base_attack():
	state = CAST
	for spirit in spirit_pivot.get_children():
		spirit.cast_spell(stats_instance)

func cast_skill_1():
	pass
	
func cast_skill_2():
	pass

func _on_PickUpZone_body_entered(body):
	body.pick_up(self)


func _on_HurtBox_area_entered(area):
	take_damage(area.damage)

const player_data = {
	'MAX_HP': 100,
	'LVL': 1,
	'MOVE_SPEED': 300.0,
	'DASH_SPEED': 600.0,
	'CDR': 0.0,
	'ATTACK_SPEED': 2.0,
	'PROJECTILE_SPEED': 500.0,
	'CAST_DURATION': 100,
	'INCREASE_AREA': 0.0,
	'DAMAGE': 20.0,
	'DARK_AMPLIFY': 0,
	'WINDOW_AMPLIFY': 0,
	'LIGHTING_AMPLIFY': 0,
	'FIRE_AMPLIFY': 0,
	'DARK_RESIST': 0,
	'WINDOW_RESIST': 0,
	'LIGHTING_RESIST': 0,
	'FIRE_RESIST': 0,
}
