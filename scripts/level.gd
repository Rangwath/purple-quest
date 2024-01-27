extends Node2D

@onready var hud = $UICanvas/HUD

var player = null
var gems_amount = 0


func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player == null:
		push_error("Player is not in the scene")
		return
		
	var gems = get_tree().get_nodes_in_group("gems")
	for gem in gems:
		gem.gem_picked.connect(_on_gem_picked)
		
	hud.set_gems_amount_label(gems_amount)


func _on_gem_picked(amount):
	gems_amount += amount
	hud.set_gems_amount_label(gems_amount)
