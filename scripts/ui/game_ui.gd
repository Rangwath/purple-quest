extends CanvasLayer

@onready var win_screen = $WinScreen
@onready var pause_screen = $PauseScreen
@onready var win_screen_next_button = $WinScreen/NextButton
@onready var pause_screen_restart_button = $PauseScreen/RestartButton

var level_scene = null
var next_level = null


func _ready():
	level_scene = get_tree().current_scene
	next_level = level_scene.next_level
	
	if next_level == null:
		win_screen_next_button.text = "FINISH"


func _input(event):
	if event.is_action_pressed("pause") && not level_scene.is_level_finished:
		pause_screen.visible = not pause_screen.visible
		if pause_screen.visible:
			pause_screen_restart_button.grab_focus()
			get_tree().paused = true
		else:
			get_tree().paused = false


func show_win_screen(flag: bool):
	win_screen.visible = flag
	win_screen_next_button.grab_focus()


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
