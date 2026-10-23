extends Area2D
const ROLL_COST: int = 1

var player_near := false

@onready var label: Label = $Label

func _on_body_entered(body: Node2D) -> void:
	if body is Doni:
		player_near = true
		label.text = "E: ролл времени"

func _on_body_exited(body: Node2D) -> void:
	if body is Doni:
		player_near = false
		label.text = "E: ролл за %d мон." % ROLL_COST

func _unhandled_input(event: InputEvent) -> void:
	if not player_near:
		return

	if event.is_action_pressed("gamble") and not event.is_echo():
		get_viewport().set_input_as_handled()
		roll_time()
		
func roll_time() -> void:
	if GameData.coins < ROLL_COST:
		label.text = "Не хватает монет"
		return

	GameData.coins -= ROLL_COST

	var bonus_time := randi_range(1, 3)
	GameData.time_limit += bonus_time

	label.text = "Выпало +%d секунд!" % bonus_time
	print("Теперь лимит времени: ", GameData.time_limit)
