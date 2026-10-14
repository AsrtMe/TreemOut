extends State

@export var player: Doni
var restart_panel: Control

func Enter() -> void:
	player.velocity.x = 0
	print("Персонаж умер")

	if restart_panel == null:
		make_restart_ui()

	restart_panel.visible = true

func physics_Update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta

	player.move_and_slide()

func make_restart_ui() -> void:
	var layer := CanvasLayer.new()
	add_child(layer)

	restart_panel = CenterContainer.new()
	restart_panel.visible = false
	restart_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(restart_panel)

	var button := Button.new()
	button.text = "Начать заново"
	button.custom_minimum_size = Vector2(260, 58)
	button.add_theme_font_size_override("font_size", 24)
	button.pressed.connect(restart_level)
	restart_panel.add_child(button)

func restart_level() -> void:
	get_tree().reload_current_scene()
