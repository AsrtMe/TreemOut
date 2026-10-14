extends Node2D

@export var fall_y := 900.0

var player: Doni
var game_over := false
@onready var death_screen: CanvasLayer = $DeathScreen

func _ready() -> void:
	player = $DONI
	death_screen.hide()
	player.died.connect(_on_player_died)

func _physics_process(_delta: float) -> void:
	if not game_over and player.global_position.y > fall_y:
		game_over = true
		player.die()

func _on_player_died() -> void:
	game_over = true
	death_screen.show()
