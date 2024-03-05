extends Node2D

@export var score_time_limit = 30

@onready var game_ui = $GameUI
@onready var hud = $GameUI/HUD
@onready var start = $Start
@onready var end = $End
@onready var levelTimer = $LevelTimer

var player = null
var gems_amount = 0
var elapsed_level_time = 0


func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player == null:
		push_error("Player is not in the scene")
		return
	player.player_spawned.connect(_on_player_spawned)
	player.player_killed.connect(_on_player_killed)
	
	var all_gems = get_tree().get_nodes_in_group("gems")
	for gem in all_gems:
		gem.gem_picked.connect(_on_gem_picked)
		
	end.body_entered.connect(_on_end_body_entered)
		
	hud.set_gems_amount_label(gems_amount)
	hud.set_timer_label("0.00")
	
	spawn_player_after_delay(0.5)


func _physics_process(_delta):
	if (not levelTimer.is_stopped()):
		hud.set_timer_label(str(get_elapsed_level_time()).pad_decimals(2))


func _on_player_spawned():
	levelTimer.start()


func _on_player_killed():
	reload_scene_after_delay(0.8)


func _on_gem_picked(amount):
	gems_amount += amount
	hud.set_gems_amount_label(gems_amount)


func _on_end_body_entered(_body):
	hud.set_timer_label(str(get_elapsed_level_time()).pad_decimals(2))
	levelTimer.stop()
	
	player.enter_portal()
	
	await get_tree().create_timer(2).timeout
	game_ui.show_win_screen(true)
	calculate_and_display_score()


func spawn_player_after_delay(delay):
	await get_tree().create_timer(delay).timeout
	player.spawn_player(start.get_spawn_position())


func reload_scene_after_delay(delay):
	await get_tree().create_timer(delay).timeout
	SceneTransition.reload_scene()


func get_elapsed_level_time():
	if (not levelTimer.is_stopped()):
		elapsed_level_time = levelTimer.wait_time - levelTimer.time_left
	
	return elapsed_level_time


func calculate_and_display_score():
	var timer_score = 0
	
	if (get_elapsed_level_time() < score_time_limit):
		timer_score = floor((score_time_limit - get_elapsed_level_time()) * 100)
	
	var gems_score = gems_amount * 1000
	var total_score = timer_score + gems_score
	
	game_ui.set_timer_score_label(str(timer_score))
	game_ui.set_gems_score_label(str(gems_score))
	game_ui.set_total_score_label(str(total_score))
	
