extends "res://src/scripts/body_physics.gd"

onready var animationNode = $AnimationNode
onready var sprite = $AnimationNode/sprite
onready var animationPlayer = $AnimationNode/AnimationPlayer
onready var muzzle = $Muzzle
onready var muzzle_spawn = $Muzzle/Spawn_position
onready var Ui = $Camera2D/Ui
onready var spirit_pivot = $Spirts_pivot
onready var dash_pivot = $AnimationNode/Dash_pivot

var stats_system = preload('res://src/scripts/stats_system.gd').STAT_SYSTEM
var base_attack = preload("res://src/skills/base/attack/attack.tscn")
var dash_effect = preload("res://src/effects/dash/dash.tscn")

var stats_instance = null
var dash_is_cd = false

enum {
	IDLE,
	MOVE,
	DEATH,
	CAST,
	DASH
}

var state = IDLE

func _ready():
	stats_instance = stats_system.new(300)
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
			get_tree().change_scene("res://ui/Root_menu.tscn")
		CAST:
			state_cast()
		DASH:
			state_dash()

	if Input.is_action_pressed("click_skill_1") and state != CAST:
		state = CAST
		animationPlayer.play("cast_2")
	if Input.is_action_pressed("click_skill_2") and state != CAST:
		state = CAST
		animationPlayer.play("cast_2")
	if Input.is_action_pressed("attack_click") and state != CAST:
		state = CAST
		animationPlayer.play("base_attack")
	if Input.is_action_pressed("dash"):
		var dash_instance = dash_effect.instance()
		dash_instance.scale.x = -1
		dash_instance.global_position = dash_pivot.global_position 
		get_tree().current_scene.add_child(dash_instance)
		
#		get_tree().add_child(dash_instance)
		state = DASH
	
func state_idle():
	Motion = Vector2()
	animationPlayer.play("idle")
	if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left") || Input.is_action_pressed("move_down") || Input.is_action_pressed("move_up"):
		state = MOVE

func state_move():
	Motion = Vector2()
	animationPlayer.play("run")
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
	Motion = Motion.normalized() * stats_instance.MOVE_SPEED

func state_dash():
#	доделать состояние рывка
	Motion = Vector2()
	animationPlayer.play("dash")
	if animationNode.scale.x == 1:
		_MotionRight()
	else:
		_MotionLeft()
	Motion = Motion * stats_instance.DASH_SPEED

func take_damage():
	sprite.material.set_shader_param('whiten', true)
	yield(get_tree().create_timer(0.2), "timeout")
	sprite.material.set_shader_param('whiten', false)

func take_EXP(value):
	stats_instance.EXP += value
	if (stats_instance.EXP + value) >= stats_instance.MAX_EXP:
		lvl_up()
		Ui.load_player_info(stats_instance)

func lvl_up():
	Ui.open_upgrade_menu(spirit_pivot)
	stats_instance.lvl_up()

func upgrade_spirit(link):
	var spirit_instance = load(link).instance()
	spirit_instance.stats_instance = stats_instance
	for spirit_wrapper in spirit_pivot.get_children():
		if(spirit_wrapper.get_children().empty()):
			spirit_wrapper.add_child(spirit_instance)
			break

func state_cast():
	animationPlayer.playback_speed = stats_instance.ATTACK_SPEED
	if global_position.x > get_global_mouse_position().x:
		animationNode.scale.x = -1
	else:
		animationNode.scale.x = 1
	Motion = Vector2()

func end_cast():
	animationPlayer.playback_speed = 1
	state = IDLE

func cast_base_attack():
	state = CAST
	for spirit_wrapper in spirit_pivot.get_children():
		if(!spirit_wrapper.get_children().empty()):
			spirit_wrapper.get_children()[0].cast_spell(stats_instance)

func cast_skill_1():
	pass
	
func cast_skill_2():
	pass

func _on_PickUpZone_body_entered(body):
	body.pick_up(self)
