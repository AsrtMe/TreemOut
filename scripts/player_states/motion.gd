extends State
class_name Motion

@export var player: Doni
@onready var animated_sprite: AnimatedSprite2D = player.get_node("AnimatedSprite2D")

func Enter() -> void:
	animated_sprite.stop()

	if name == "Air":
		animated_sprite.play("Jump")
	elif name == "Run":
		animated_sprite.play("Run")
	else:
		animated_sprite.play("idle")

func physics_Update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	else:
		player.velocity.y = 0.0

	player.velocity.x = Input.get_axis("left", "right") * player.speed
	
	if not is_zero_approx(player.velocity.x):
		animated_sprite.flip_h = player.velocity.x < 0

	if Input.is_action_just_pressed("jump") and player.jumps_left > 0:
		player.velocity.y = -player.jump_speed
		player.jumps_left -= 1
		animated_sprite.stop()
		animated_sprite.play("Jump")

	player.move_and_slide()

	if player.is_on_floor():
		reset_jumps()

	var next_state := "air"
	if player.is_on_floor():
		next_state = "run" if not is_zero_approx(player.velocity.x) else "idle"
	if next_state != String(name).to_lower():
		Transitioned.emit(self, next_state)


func reset_jumps() -> void:
	player.jumps_left = 1
