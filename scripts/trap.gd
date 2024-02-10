class_name Trap

extends Node2D

signal player_touched_trap


func _on_body_entered(body):
	if body is Player:
		player_touched_trap.emit()
