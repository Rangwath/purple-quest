extends Control

@export var first_level: PackedScene = null

@onready var main_menu_focus_button = $PlayButton


func _ready():
	main_menu_focus_button.grab_focus()
	
	MusicPlayer.start_music()


func _on_play_button_pressed():
	if first_level == null:
		push_error("The first level scene is not set")
		return
	
	HighscoreHandler.clear_current_playthrough_highscore()
	
	MusicPlayer.fade_out_music()
	
	SceneTransition.change_scene(first_level)


func _on_highscore_button_pressed():
	SceneTransition.load_highscore_menu_scene()


func _on_controls_button_pressed():
	SceneTransition.load_controls_menu_scene()
