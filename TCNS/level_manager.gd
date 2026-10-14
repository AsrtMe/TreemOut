extends Node2D

@export var fall_y := 900.0

var player: Doni
var game_over := false

func _ready() -> void:
	player = $DONI

func _physics_process(_delta: float) -> void:
	if not game_over and player.global_position.y > fall_y:
		game_over = true
		player.die()
