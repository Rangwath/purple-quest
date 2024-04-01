class_name Gem

extends Area2D

signal gem_picked(amount)

const TIMER_FROM = 2.0
const TIMER_TO = 5.0

@export var amount: int = 1

@onready var animation_timer = $AnimationTimer
@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	animation_timer.wait_time = randf_range(TIMER_FROM, TIMER_TO)
	animation_timer.start()


func _on_body_entered(body):
	if body is Player:
		gem_picked.emit(amount)
		queue_free()


func _on_animation_timer_timeout():
	animated_sprite.play("shine")
	animation_timer.wait_time = randf_range(TIMER_FROM, TIMER_TO)
	animation_timer.start()
