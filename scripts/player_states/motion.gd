extends State
class_name Motion

@export var player: Doni


func physics_Update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += player.GRAVITY * delta
	else:
		player.velocity.y = 0.0

	player.velocity.x = Input.get_axis("left", "right") * player.SPEED

	if Input.is_action_just_pressed("jump") and player.cj > 0:
		player.velocity.y = -player.JUMP
		player.cj -= 1

	player.move_and_slide()

	if player.is_on_floor():
		rjc()

	var next_state := "air"
	if player.is_on_floor():
		next_state = "run" if not is_zero_approx(player.velocity.x) else "idle"
	if next_state != String(name).to_lower():
		Transitioned.emit(self, next_state)


func rjc() -> void:
	player.cj = 1
