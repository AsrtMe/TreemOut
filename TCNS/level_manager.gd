extends Node2D

@export var fall_y := 900.0

var player: CharacterBody2D
var restart_panel: Control
var game_over := false

func _ready() -> void:
	player = $DONI
	make_restart_ui()

func _physics_process(_delta: float) -> void:
	if not game_over and player.global_position.y > fall_y:
		show_restart()

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

func show_restart() -> void:
	game_over = true
	player.velocity = Vector2.ZERO
	player.set_physics_process(false)
	restart_panel.visible = true

func restart_level() -> void:
	get_tree().reload_current_scene()
