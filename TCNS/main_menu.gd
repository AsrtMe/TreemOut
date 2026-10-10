extends Control

const LEVEL_SCENE := "res://TCNS/lvl_2d.tscn"
const BACKGROUND_IMAGE := preload("res://assets/menu_background_hd.png")


var main_menu: VBoxContainer
var settings_menu: VBoxContainer
var info_label: Label
var bg_image: TextureRect
var bg_time := 0.0


func _ready() -> void:
	build_menu()

func _process(delta: float) -> void:
	bg_time += delta
	if bg_image:
		bg_image.position.x = -28.0 + sin(bg_time * 0.12) * 6.0
		bg_image.position.y = -20.0 + cos(bg_time * 0.10) * 4.0
		bg_image.scale = Vector2.ONE * (1.012 + sin(bg_time * 0.08) * 0.003)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and settings_menu.visible:
		show_main_menu()

func build_menu() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)

	bg_image = TextureRect.new()
	bg_image.texture = BACKGROUND_IMAGE
	bg_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	bg_image.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg_image.offset_left = -56
	bg_image.offset_top = -42
	bg_image.offset_right = 56
	bg_image.offset_bottom = 42
	add_child(bg_image)

	var dark := ColorRect.new()
	dark.color = Color(0.02, 0.06, 0.04, 0.24)
	dark.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(dark)

	var panel := PanelContainer.new()
	panel.set_anchors_preset(Control.PRESET_CENTER)
	panel.offset_left = -260
	panel.offset_top = -250
	panel.offset_right = 260
	panel.offset_bottom = 250
	panel.add_theme_stylebox_override("panel", make_box(Color(0.07, 0.16, 0.12, 0.86)))
	add_child(panel)

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 28)
	margin.add_theme_constant_override("margin_right", 28)
	margin.add_theme_constant_override("margin_top", 28)
	margin.add_theme_constant_override("margin_bottom", 28)
	panel.add_child(margin)

	main_menu = VBoxContainer.new()
	main_menu.alignment = BoxContainer.ALIGNMENT_CENTER
	main_menu.add_theme_constant_override("separation", 14)
	margin.add_child(main_menu)

	main_menu.add_child(make_title("GAMBA IN\nTHE FOREST"))
	main_menu.add_child(make_text("Лесной 2D-паркур про эльфов, удачу и мини-казино."))
	main_menu.add_child(make_button("Играть", start_game))
	main_menu.add_child(make_button("Настройки", show_settings))
	main_menu.add_child(make_button("Как играть", show_how_to_play))
	main_menu.add_child(make_button("Выход", quit_game))

	info_label = make_text("A/D — движение, Space — прыжок. Звуки добавим позже.")
	main_menu.add_child(info_label)

	settings_menu = VBoxContainer.new()
	settings_menu.visible = false
	settings_menu.alignment = BoxContainer.ALIGNMENT_CENTER
	settings_menu.add_theme_constant_override("separation", 14)
	margin.add_child(settings_menu)

	settings_menu.add_child(make_title("Настройки"))
	settings_menu.add_child(make_text("Громкость"))

	var volume := HSlider.new()
	volume.min_value = 0
	volume.max_value = 100
	volume.value = 80
	volume.value_changed.connect(set_volume)
	settings_menu.add_child(volume)
	set_volume(volume.value)

	var fullscreen := CheckButton.new()
	fullscreen.text = "Полный экран"
	fullscreen.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	fullscreen.toggled.connect(set_fullscreen)
	settings_menu.add_child(fullscreen)

	var vsync := CheckButton.new()
	vsync.text = "VSync"
	vsync.button_pressed = true
	vsync.toggled.connect(set_vsync)
	settings_menu.add_child(vsync)

	settings_menu.add_child(make_button("Назад", show_main_menu))

func make_title(text: String) -> Label:
	var label := Label.new()
	label.text = text
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 42)
	label.add_theme_color_override("font_color", Color("f2c94c"))
	return label

func make_text(text: String) -> Label:
	var label := Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 18)
	label.add_theme_color_override("font_color", Color("d8ead6"))
	return label

func make_button(text: String, action: Callable) -> Button:
	var button := Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(0, 52)
	button.add_theme_font_size_override("font_size", 22)
	button.pressed.connect(action)
	return button

func make_box(color: Color) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.border_color = Color("f2c94c")
	box.set_border_width_all(2)
	box.set_corner_radius_all(20)
	return box

func start_game() -> void:
	get_tree().change_scene_to_file(LEVEL_SCENE)

func show_settings() -> void:
	main_menu.visible = false
	settings_menu.visible = true

func show_main_menu() -> void:
	settings_menu.visible = false
	main_menu.visible = true

func show_how_to_play() -> void:
	info_label.text = "Проходи лесной паркур, собирай бонусы-прыжки. Позже добавим мини-казино между уровнями."

func quit_game() -> void:
	get_tree().quit()

func set_volume(value: float) -> void:
	var bus := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus, linear_to_db(max(value / 100.0, 0.001)))
	AudioServer.set_bus_mute(bus, value <= 0.0)

func set_fullscreen(enabled: bool) -> void:
	var mode := DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED
	DisplayServer.window_set_mode(mode)

func set_vsync(enabled: bool) -> void:
	var mode := DisplayServer.VSYNC_ENABLED if enabled else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(mode)
