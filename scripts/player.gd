class_name Player

extends CharacterBody2D

@export var movement_speed = 90
@export var jump_force = 160
@export var min_jump_force = 100
@export var gravity = 400

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_coyote_timer = $JumpCoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer

var input_direction


func _physics_process(delta):
	apply_gravity(delta)
	process_movement()
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor && not is_on_floor():
		jump_coyote_timer.start()
	
	process_jumping()
	update_animations()


func process_movement():
	input_direction = Input.get_axis("move_left", "move_right")
	
	if input_direction > 0:
		animated_sprite.flip_h = false
	elif  input_direction < 0:
		animated_sprite.flip_h = true
		
	velocity.x = input_direction * movement_speed


func process_jumping():
	if Input.is_action_just_pressed("jump"): 
		if is_on_floor() || not jump_coyote_timer.is_stopped():
			jump_coyote_timer.stop()
			velocity.y = - jump_force
		else:
			jump_buffer_timer.start()
	
	#Player can release the button early to not jump so high
	if Input.is_action_just_released("jump") && velocity.y < - min_jump_force:
		velocity.y = - min_jump_force
		
	# If player touched the floor and the JumpBufferTimer is running, jump
	if is_on_floor() && not jump_buffer_timer.is_stopped():
		jump_buffer_timer.stop()
		if Input.is_action_pressed("jump"):
			velocity.y = - jump_force
		else:
			velocity.y = - min_jump_force


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
