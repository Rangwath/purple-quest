extends Control

@onready var focus_button = $MainMenuButton
@onready var score_box_container = $ScoreBoxContainer


func _ready():
	focus_button.grab_focus()
	
	MusicPlayer.start_music()
	
	populate_score()


func _on_main_menu_button_pressed():
	SceneTransition.load_main_menu_scene()


func populate_score():
	var highscore = HighscoreHandler.get_playthrough_highscore()
	
	for score_label in score_box_container.get_children():
		print(score_label.name.to_int())
		var level_id = score_label.name.to_int()
		score_label.text = str(highscore.get(level_id))
