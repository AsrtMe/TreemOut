extends AnimatableBody2D

@export var speed: float = 500
@export var distance: float = 150

var start_y: float
var direction: float = 1.0

func _ready():
	start_y = position.y

func _physics_process(delta):
	position.y += speed * direction * delta

	if position.y >= start_y + distance:
		direction = -1.0

	elif position.y <= start_y - distance:
		direction = 1.0

func _on_killarea_body_entered(body: Node2D) -> void:
	if body is Doni:
		body.die()
