extends CanvasLayer

@onready var animation_player = $AnimationPlayer

@export var main_menu: PackedScene = null


func change_scene(target_scene : PackedScene):
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(target_scene)
	animation_player.play_backwards("dissolve")


func reload_scene():
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	animation_player.play_backwards("dissolve")


func load_main_menu_scene():
	if main_menu == null:
		push_error("Main menu scene is not set")
		return
	
	change_scene(main_menu)
