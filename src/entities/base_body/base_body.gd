extends KinematicBody2D
class_name Base_body

const floating_indicator = preload("res://src/ui/floating_indicator/floating_indicator.tscn")
const DOT_bleed = preload("res://src/attacks/DOT/bleed/bleed.tscn")

onready var STATS: Stat_system = $STATS
onready var sprite: Sprite = $Sprite
onready var collShape: CollisionShape2D = $CollisionShape2D
onready var animation: AnimationPlayer = $AnimationPlayer
onready var health_bar: ProgressBar = $Helth_bar
onready var ray_cast: RayCast2D = $RayCast
onready var weapon_slot: Node2D = $RayCast/Weapon_slot
onready var off_wepon_slot: Node2D = $Off_wepon_slot
onready var hurtbox_shape: CollisionShape2D = $Hurtbox/CollisionShape2D
onready var passive_list: Node = $Passive_list
onready var ability_list: Node = $Ability_list
onready var effect_list: Node2D = $effect_list
onready var bleed: Base_DOT = $effect_list/bleed
onready var hit_particles := $HitParticles

export (int) var BASE_ACCELERATION = 2000
export (int) var ACCELERATION = BASE_ACCELERATION

var Motion = Vector2.ZERO
var axis = Vector2.ZERO

enum {
	MOVE,
	IDLE,
	ATTACK,
}

var state = IDLE
var is_combat = false

signal death
signal take_damage

func _physics_process(delta):
	health_bar.max_value = STATS.get_max_health()
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
		ray_cast.show_behind_parent = true
		off_wepon_slot.show_behind_parent = false
	else:
		ray_cast.show_behind_parent = false
		off_wepon_slot.show_behind_parent = true
#	if is_combat: 
#		ray_cast.position.y =  sin(OS.get_ticks_msec() * delta * 0) * 2
#	else:
#		ray_cast.position.y = sin(OS.get_ticks_msec() * delta * 0.20) * 2
		

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
#	animation_tree.get("parameters/playback").travel("idle")

func state_move(delta):
	apply_movement(axis * (STATS.get_move_speed() * 10) * delta, STATS.get_move_speed())

func take_damage(type, damage: int, attack_type = CONSTANTS.DAMAGE_WEIGHT_ENUM.BASE):
	var damage_view = floating_indicator.instance()
	var applied_damage = STATS.apply_damage_and_return(type, damage)
	
	get_tree().get_root().add_child(damage_view)
	damage_view.execute(self, applied_damage, attack_type)
	
	if STATS.CURRENT_HEALTH <= 0:
		emit_signal('death')

func _on_Hurtbox_area_entered(attack: Base_attack):
	emit_signal("take_damage", attack)
	take_damage(attack.damage_type, attack.damage, attack.damage_weight)
	take_effects(attack)
	take_damage_effect(attack)
	

func take_damage_effect(attack):
	hit_particles.restart()
	hit_particles.emitting = true
	hit_particles.rotation = get_angle_to(attack.global_position) + PI
	sprite.material.set_shader_param("mix_weight", 0.9)
	sprite.material.set_shader_param("hit", true)
#	TODO НУЖНО ПРАВИТЬ!!!
	yield(get_tree().create_timer(0.2), "timeout")
	sprite.material.set_shader_param("hit", false)

func take_effects(attack: Base_attack):
	var bleed_stack: int = attack.effect_tags.count(CONSTANTS.EFFECT_TAG_ENUM.BLEED)
	if bleed_stack > 0:
		bleed.update_info(attack.owner_body, self, bleed_stack)

#РЕГУЛЯРНЫЙ РЕГЕН ХП И МАНЫ
func _on_Regen_timer_timeout():
	STATS.regen_helth()
	STATS.regen_mana()
