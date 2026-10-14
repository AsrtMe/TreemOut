extends State
class_name Motion

@export var player: Doni


func physics_Update(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	else:
		player.velocity.y = 0.0

	player.velocity.x = Input.get_axis("left", "right") * player.speed

	if Input.is_action_just_pressed("jump") and player.jumps_left > 0:
		player.velocity.y = -player.jump_speed
		player.jumps_left -= 1

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
