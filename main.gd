extends Node


func _on_hud_control_on_create_egg() -> void:
	%WorldNode3D.create_egg()


func _on_world_node_3d_on_update_total_pollen(pollen: int) -> void:
	%HudControl.update_pollen_label(pollen)
