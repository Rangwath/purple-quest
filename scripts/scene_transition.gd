extends CanvasLayer

@onready var animation_player = $AnimationPlayer

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
