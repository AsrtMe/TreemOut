extends Area2D
var collected := false

func _ready() -> void:
	$AnimatedSprite2D.play("spin")


func _on_body_entered(body: Node2D) -> void:
	if not (body is Doni) or collected:
		return

	if body.state_machine.current_state.name == "Dead":
		return

	collected = true
	GameData.coins += 1
	print("Монет: ", GameData.coins)

	$AnimatedSprite2D.play("collect")
	await $AnimatedSprite2D.animation_finished
	queue_free()
