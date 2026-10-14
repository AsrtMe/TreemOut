extends Node
class_name StateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[String(child.name).to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	print(states)

	if initial_state != null and initial_state.get_parent() == self:
		current_state = initial_state
		current_state.Enter()
	else:
		push_error("StateMachine requires an initial state among its children.")

func update(delta: float) -> void:
	if current_state != null:
		current_state.Update(delta)


func physics_update(delta: float) -> void:
	if current_state != null:
		current_state.physics_Update(delta)


func on_child_transition(state: State, new_state_name: String) -> void:
	if state != current_state:
		return

	var new_state: State = states.get(new_state_name.to_lower())
	if new_state == null or new_state == current_state:
		return

	current_state.Exit()
	current_state = new_state
	current_state.Enter()
