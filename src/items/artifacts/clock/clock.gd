extends Item_with_popup

export (int) var CDR = 10

func _on_clock_item_entered(body):
	body.STATS.apply_buff({
		"GAIN_CDR": CDR
	})

func _on_clock_item_exited(body):
	body.STATS.apply_buff({
		"GAIN_CDR": -CDR
	})
