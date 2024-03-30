extends CanvasLayer

var next_level = null


func _ready():
	next_level = get_tree().current_scene.next_level


func show_win_screen(flag: bool):
	$WinScreen.visible = flag


func set_timer_score_label(score):
	$WinScreen/TimerScoreValueLabel.text = str(score)


func set_gems_score_label(score):
	$WinScreen/GemsScoreValueLabel.text = str(score)


func set_total_score_label(score):
	$WinScreen/TotalScoreValueLabel.text = str(score)


func _on_next_button_pressed():
	if next_level == null:
		push_error("There is no next scene and there is no winning!")
		return
	
	SceneTransition.change_scene(next_level)


func _on_restart_button_pressed():
	SceneTransition.reload_scene()
