extends Area2D

func _ready() -> void:
	$AnimatedSprite2D.play("def")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_bonus"):
		body.get_bonus()
		queue_free()
