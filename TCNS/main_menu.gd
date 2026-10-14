extends Control

const LEVEL_SCENE := "res://TCNS/lvl_2d.tscn"


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(LEVEL_SCENE)
