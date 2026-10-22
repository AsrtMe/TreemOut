extends Control

const HUB_SCENE := "res://TCNS/hub.tscn"


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(HUB_SCENE)
