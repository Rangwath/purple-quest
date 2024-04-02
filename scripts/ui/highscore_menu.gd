extends Control

@onready var focus_button = $MainMenuButton
@onready var score_box_container = $ScoreBoxContainer
@onready var total_score_label = $TotalScoreLabel


func _ready():
	focus_button.grab_focus()
	
	populate_score()


func populate_score():
	var highscore = HighscoreHandler.get_total_highscore()
	var total_score = 0
	
	for score_label in score_box_container.get_children():
		var level_id = score_label.name.to_int()
		var level_score = 0
		
		if highscore.get(level_id) != null:
			level_score = highscore.get(level_id)
		
		score_label.text = str(level_score)
		total_score += level_score
	
	total_score_label.text = str(total_score)


func _on_main_menu_button_pressed():
	SceneTransition.load_main_menu_scene()
