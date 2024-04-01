extends CanvasLayer

@onready var next_button = $WinScreen/NextButton

var next_level = null


func _ready():
	next_button.grab_focus()
	
	next_level = get_tree().current_scene.next_level
	
	if next_level == null:
		next_button.text = "FINISH"


func show_win_screen(flag: bool):
	$WinScreen.visible = flag
	next_button.grab_focus()


func set_timer_score_label(score):
	$WinScreen/TimerScoreValueLabel.text = str(score)


func set_gems_score_label(score):
	$WinScreen/GemsScoreValueLabel.text = str(score)


func set_total_score_label(score):
	$WinScreen/TotalScoreValueLabel.text = str(score)


func _on_next_button_pressed():
	if next_level == null:
		SceneTransition.load_win_game_menu_scene()
	else:
		SceneTransition.change_scene(next_level)


func _on_restart_button_pressed():
	SceneTransition.reload_scene()


func _on_main_menu_button_pressed():
	SceneTransition.load_main_menu_scene()
