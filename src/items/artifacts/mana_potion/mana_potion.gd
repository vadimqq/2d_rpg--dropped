extends Item_with_popup

var count = 1

func _init():
	item_name = "Mana potion"
	description = "increases max mana"
	stats = {
		"MANA": 10
	}