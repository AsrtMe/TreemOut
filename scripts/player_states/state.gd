extends Node
class_name State

signal Transitioned(state: State, new_state_name: String)


func Enter() -> void:
	pass


func Exit() -> void:
	pass


func Update(_delta: float) -> void:
	pass


func physics_Update(_delta: float) -> void:
	pass
