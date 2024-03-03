extends Node2D

@onready var hud = $UICanvas/HUD
@onready var start = $Start
@onready var end = $End
@onready var levelTimer = $LevelTimer

var player = null
var gems_amount = 0


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


func _process(_delta):
	if (not levelTimer.is_stopped()):
		hud.set_timer_label(str(levelTimer.wait_time - levelTimer.time_left).pad_decimals(2))


func _on_player_spawned():
	levelTimer.start()

func _on_player_killed():
	reload_scene_after_delay(0.8)


func _on_gem_picked(amount):
	gems_amount += amount
	hud.set_gems_amount_label(gems_amount)


func _on_end_body_entered(_body):
	hud.set_timer_label(str(levelTimer.wait_time - levelTimer.time_left).pad_decimals(2))
	levelTimer.stop()
	player.enter_portal()
	reload_scene_after_delay(2)


func spawn_player_after_delay(delay):
	await get_tree().create_timer(delay).timeout
	player.spawn_player(start.get_spawn_position())


func reload_scene_after_delay(delay):
	await get_tree().create_timer(delay).timeout
	SceneTransition.reload_scene()
