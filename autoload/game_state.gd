extends Node

signal on_update_total_pollen(value: int)

var total_pollen: int = 0:
	set(value):
		on_update_total_pollen.emit(value)
