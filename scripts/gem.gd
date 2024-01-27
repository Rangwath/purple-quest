class_name Gem

extends Area2D

signal gem_picked(amount)

@export var amount = 1


func _on_body_entered(body):
	if body is Player:
		gem_picked.emit(amount)
		queue_free()
