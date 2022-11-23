extends VBoxContainer

onready var attack_speed = $Tier_1/attack_speed

onready var arrow_multishot = $Tier_2/arrow_multishot
onready var bleed = $Tier_2/bleed

onready var dash = $Tier_3/dash

func _ready():
	pass

func load_info():
	arrow_multishot.ability_name = "arrow_multishot"
	arrow_multishot.load_info()
	
	dash.ability_name = "dash"
	dash.load_info()
	
	attack_speed.ability_name = "physic_attack_speed"
	attack_speed.ability_type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	attack_speed.load_info()
	
	bleed.ability_name = "physic_bleed"
	bleed.ability_type = CONSTANTS.ABILITY_TYPE_ENUM.PASSIVE
	bleed.load_info()
