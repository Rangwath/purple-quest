class_name Player

extends CharacterBody2D

@export var movement_speed = 100
@export var jump_force = 150
@export var gravity = 400

@onready var animated_sprite = $AnimatedSprite2D

var input_direction


func _physics_process(delta):
	apply_gravity(delta)
	apply_movement()
	move_and_slide()
	apply_jump_force(jump_force)
	update_animations()

func apply_movement():
	input_direction = Input.get_axis("move_left", "move_right")
	
	if input_direction > 0:
		animated_sprite.flip_h = false
	elif  input_direction < 0:
		animated_sprite.flip_h = true
		
	velocity.x = input_direction * movement_speed


func apply_jump_force(force):
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = - force


func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500


func update_animations():
	if is_on_floor():
		if input_direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
