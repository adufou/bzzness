extends Node

var total_pollen: int = 0:
	set(value):
		%HudControl.update_pollen_label(value)
