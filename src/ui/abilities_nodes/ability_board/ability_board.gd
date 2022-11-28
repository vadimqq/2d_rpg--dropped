extends CanvasLayer

class_name Ability_board

onready var physic_tree = $VBoxContainer/HBoxContainer/Physic_tree

onready var physic_button = $VBoxContainer/HBoxContainer/GridContainer/Physic_button
onready var material_counter = $VBoxContainer/HBoxContainer/GridContainer/Material_counter
onready var ability_list = $VBoxContainer/Ability_list

onready var dict = {
	"physic_tree": physic_tree
}

var active_tree: VBoxContainer = physic_tree

func _ready():
	active_tree = dict["physic_tree"]

func _process(delta):
	material_counter.text =  "Soul stones: " + str(CURRENCY_MANAGER.soul_coins)

func open():
	active_tree.load_info()
	ability_list.set_icons()

func open_tree(name):
	active_tree.visible = false
	active_tree = dict[name]
	active_tree.load_info()
	active_tree.visible = true

func _on_Physic_button_button_down():
	open_tree("physic_tree")
