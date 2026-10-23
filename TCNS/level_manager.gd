extends Node2D

@export var fall_y := 900.0

var start_y: float = 0.0
var player: Doni
var game_over := false
@onready var death_screen: CanvasLayer = $DeathScreen
@onready var run_timer: Timer = $RunTimer
@onready var time_label: Label = $HUD/TimeLabel
@onready var coins_label: Label = $HUD/CoinsLabel
@onready var height_label: Label = $HUD/HeightLabel

func _ready() -> void:
	player = $DONI
	death_screen.hide()
	player.died.connect(_on_player_died)
	run_timer.timeout.connect(_on_run_timer_timeout)
	run_timer.start(GameData.time_limit)
	start_y = player.global_position.y

func _physics_process(_delta: float) -> void:
	if not game_over and player.global_position.y > fall_y:
		game_over = true
		player.die()

func _on_player_died() -> void:
	game_over = true
	death_screen.show()
	run_timer.stop()
	death_screen.show()
	
func _on_run_timer_timeout() -> void:
	if not game_over:
		time_label.text = "Время: 0"
		player.die()

func _process(_delta: float) -> void:
	coins_label.text = "Монеты: %d" % GameData.coins

	if not game_over:
		time_label.text = "Время: %d" % ceili(run_timer.time_left)

		var height := maxi(0, floori(start_y - player.global_position.y))
		GameData.best_height = maxi(GameData.best_height, height)

		height_label.text = "Высота: %.1f м" % GameData.pixels_to_meters(height)
