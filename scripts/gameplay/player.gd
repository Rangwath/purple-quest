class_name Player

extends CharacterBody2D

signal player_killed
signal player_spawned

@export var movement_speed: int = 100
@export var jump_force: int = 170
@export var min_jump_force: int = 100
@export var gravity: int = 400

@onready var animated_sprite = $AnimatedSprite2D
@onready var blood_vfx = $BloodExplosionParticles
@onready var portal_vfx = $PortalImplosionParticles
@onready var jump_coyote_timer = $JumpCoyoteTimer
@onready var jump_buffer_timer = $JumpBufferTimer

var input_direction
var active = true


func _ready():
	active = false
	animated_sprite.hide()
	
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.player_touched_trap.connect(on_player_touched_trap)
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		enemy.player_touched_enemy.connect(on_player_touched_enemy)


func _physics_process(delta):
	if not active:
		velocity = Vector2.ZERO
	
	apply_gravity(delta)
	
	if active:
		process_movement()
	
	var was_on_floor = is_on_floor()
		
	move_and_slide()
		
	if was_on_floor && not is_on_floor():
		jump_coyote_timer.start()
	
	if active:
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
	if active:
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


func on_player_touched_trap():
	print("Player touched trap")
	kill_player()


func on_player_touched_enemy():
	print("Player touched enemy")
	kill_player()


func _on_animation_finished():
	# When spawn animation is finished, activate the Player
	if animated_sprite.animation == "spawn":
		print("Player spawn finished")
		active = true
		print("Player Active: " + str(active))
		player_spawned.emit()


func spawn_player(spawn_position):
	print("Player spawning")
	active = false
	print("Player Active: " + str(active))
	global_position = spawn_position
	
	animated_sprite.show()
	animated_sprite.flip_h = false
	animated_sprite.play("spawn")
	
	AudioPlayer.play_player_spawn_sfx()


func kill_player():
	if not active:
		return
	
	print("Player killed")
	active = false
	print("Player Active: " + str(active))
	
	AudioPlayer.play_player_death_sfx()
	
	#Hide the Player sprite and start the blood explosion
	animated_sprite.hide()
	blood_vfx.restart()
	blood_vfx.emitting = true
	
	player_killed.emit()


func enter_portal():
	print("Player entered portal")
	active = false
	print("Player Active: " + str(active))
	
	AudioPlayer.play_portal_sfx()
	
	animated_sprite.hide()
	portal_vfx.restart()
	portal_vfx.emitting = true
