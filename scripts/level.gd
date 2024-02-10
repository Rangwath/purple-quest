extends Node2D

@onready var hud = $UICanvas/HUD
@onready var start = $Start

var player = null
var gems_amount = 0


func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player == null:
		push_error("Player is not in the scene")
		return
	player.player_killed.connect(on_player_killed)
		
	var all_gems = get_tree().get_nodes_in_group("gems")
	for gem in all_gems:
		gem.gem_picked.connect(_on_gem_picked)
		
	hud.set_gems_amount_label(gems_amount)
	
	spawn_player_after_delay(0.5)


func on_player_killed():
	spawn_player_after_delay(1)


func _on_gem_picked(amount):
	gems_amount += amount
	hud.set_gems_amount_label(gems_amount)


func spawn_player_after_delay(delay):
	await get_tree().create_timer(delay).timeout
	player.spawn_player(start.get_spawn_position())
