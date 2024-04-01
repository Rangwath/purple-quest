class_name Enemy

extends CharacterBody2D

signal player_touched_enemy

@export var movement_speed = 15

@onready var ground_check_raycast = $GroundCheckRayCast2D
@onready var wall_check_raycast = $WallCheckRayCast2D

var facing_right = true
var active = true


func _physics_process(_delta):
	if active:
		velocity.x = movement_speed
	else:
		velocity = Vector2.ZERO
	
	if not ground_check_raycast.is_colliding():
		flip()
	
	if wall_check_raycast.is_colliding():
		flip()
	
	move_and_slide()


func flip():
	facing_right = not facing_right
	
	scale.x = scale.x * -1
	
	if facing_right:
		movement_speed = abs(movement_speed)
	else:
		movement_speed = abs(movement_speed) * -1


func _on_hitbox_body_entered(body):
	if body is Player:
		active = false
		player_touched_enemy.emit()
