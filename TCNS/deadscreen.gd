extends CanvasLayer

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("Restart") and not event.is_echo():
		get_viewport().set_input_as_handled()
		_on_restart_button_pressed()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://TCNS/hub.tscn")
