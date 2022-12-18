extends Area2D

class_name Base_attack

var owner_body = null

var knockback_power = 0
var damage = 0
var damage_type = CONSTANTS.DAMAGE_TYPE_ENUM.PHYSIC
var damage_weight = CONSTANTS.DAMAGE_WEIGHT_ENUM.BASE

var area_size = 0
var effect_tags = []

var base_scale = Vector2(1,1)

func set_damage(amount, damage_weight):
	damage = amount
	damage_weight = damage_weight

func set_transform(new_transform):
	transform = new_transform

func set_rotation(new_rotation):
	rotation = new_rotation

func set_damage_type(type):
	damage_type = type

func set_collisions(collision_layer, collision_mask):
	self.collision_layer = collision_layer
	self.collision_mask = collision_mask

func set_effect_tags(pool):
	effect_tags = pool

func set_owner_body(body):
	owner_body = body
