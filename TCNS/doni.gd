extends CharacterBody2D
class_name Doni
 
var speed = 600
var jump_speed = 550
var gravity = 1500
var jumps_left = 1

const MAIN_MENU_SCENE := "res://TCNS/main_menu.tscn"

@onready var state_machine: StateMachine = $StateMachine


func _process(delta: float) -> void:
	state_machine.update(delta)


func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file(MAIN_MENU_SCENE)

func die() -> void:
	state_machine.on_child_transition(state_machine.current_state, "dead")

func get_bonus():
	jumps_left += 1
	print("Получен +1 прыжок. Сейчас прыжков: ", jumps_left)
