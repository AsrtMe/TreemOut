extends State

@export var player: Doni
var restart_panel: Control

func Enter() -> void:
	player.velocity.x = 0
	print("Персонаж умер")
	player.died.emit()

func physics_Update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta

	player.move_and_slide()
