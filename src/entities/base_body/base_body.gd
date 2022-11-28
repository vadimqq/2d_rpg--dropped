extends KinematicBody2D
class_name Base_body

var hit_particle_src = preload("res://src/effects/Hit_particle.tscn")
var floating_indicator = preload("res://src/ui/floating_indicator/floating_indicator.tscn")
const Stat_system = preload("res://src/scripts/stat_system.gd").STAT_SYSTEM
 
onready var sprite: Sprite = $Sprite
onready var collShape: CollisionShape2D = $CollisionShape2D
onready var animation: AnimationPlayer = $AnimationPlayer
onready var animation_tree: AnimationTree = $AnimationTree
onready var combat_controler: AnimationPlayer = $Combat_controller
onready var health_bar: ProgressBar = $Helth_bar
onready var ray_cast: RayCast2D = $RayCast
onready var weapon_slot: Node2D = $RayCast/Weapon_slot
onready var off_wepon_slot: Node2D = $Off_wepon_slot
onready var hurtbox_shape: CollisionShape2D = $Hurtbox/CollisionShape2D
onready var passive_list: Node2D = $Passive_list
onready var DOT_list: Node2D = $DOT_list
onready var DOT_bleed: Base_DOT = $DOT_list/bleed

export (int) var BASE_ACCELERATION = 2000
export (int) var ACCELERATION = BASE_ACCELERATION

var Motion = Vector2.ZERO
var axis = Vector2.ZERO

var STATS :Stat_system = null

enum {
	MOVE,
	IDLE,
	ATTACK
}
var state = IDLE

signal death

func _ready():
	STATS = Stat_system.new()
	health_bar.max_value = STATS.get_max_health()
	health_bar.value = STATS.CURRENT_HEALTH
	

func _physics_process(delta):
	health_bar.value = STATS.CURRENT_HEALTH

	match state:
		IDLE:
			state_idle(delta)
		MOVE:
			state_move(delta)
		
	if axis == Vector2.ZERO:
		state = IDLE
	else:
		state = MOVE
	Motion = move_and_slide(Motion)
	
	if ray_cast.transform.x.y < -0.7:
		ray_cast.z_index = 0
		off_wepon_slot.z_index = 1
	else:
		ray_cast.z_index = 1
		off_wepon_slot.z_index = 0
		

func apply_friction(amount):
	if Motion.length() > amount:
		Motion -= Motion.normalized() * amount
	else: 
		Motion = Vector2.ZERO

func apply_movement(accel, speed):
	Motion += accel
	Motion = Motion.clamped(speed)

func state_idle(delta):
	apply_friction((STATS.get_move_speed() * 10) * delta)
	animation_tree.get("parameters/playback").travel("idle")

func state_move(delta):
	apply_movement(axis * (STATS.get_move_speed() * 10) * delta, STATS.get_move_speed())

func take_damage(type, damage: int, attack_type = CONSTANTS.CAST_TYPE_ENUM.BASE):
	var damage_view = floating_indicator.instance()
	var applied_damage = STATS.apply_damage_and_return(type, damage)
	
	get_tree().get_root().add_child(damage_view)
	damage_view.execute(self, applied_damage, attack_type)
	
	if STATS.CURRENT_HEALTH <= 0:
		emit_signal('death')

func _on_Hurtbox_area_entered(attack: Base_attack):
	take_damage(attack.type, attack.damage, attack.attack_type)
	check_DOT(attack)
	var hit_particle = hit_particle_src.instance()
	get_tree().get_root().add_child(hit_particle)
	hit_particle.swich_rotation(attack, self)

func check_DOT(attack: Base_attack):
	if attack.DOT_tags.has(CONSTANTS.DOT_TYPE_ENUM.BLEED):
		DOT_bleed.update_info(attack.owner_body)
		DOT_bleed.up_stack(attack.DOT_tags.count(CONSTANTS.DOT_TYPE_ENUM.BLEED))

#РЕГУЛЯРНЫЙ РЕГЕН ХП И МАНЫ
func _on_Regen_timer_timeout():
	STATS.regen_helth()
	STATS.regen_mana()

#РЕГУЛЯРНЫЙ УРОН ОТ ДОТ
func _on_Damage_timer_timeout():
	for node in DOT_list.get_children():
		var DOT: Base_DOT = node
		DOT.apply_damage(self)
