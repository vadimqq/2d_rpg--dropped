extends Node

const HUB = "res://src/levels/hub/hub.tscn"
const GLADE = "res://src/levels/glade/glade.tscn"
const generate_map = "res://src/levels/generate_room/generate_room.tscn"
const generate_level = "res://src/levels/procedure_gen_level/Main.tscn"

var on_location = false

func load_location(name):
	if on_location:
		GAME_CORE.player.global_position = Vector2.ZERO
	on_location = true
	get_tree().change_scene(name)
