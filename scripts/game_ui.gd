extends CanvasLayer


func show_win_screen(flag: bool):
	$WinScreen.visible = flag


func _on_next_button_pressed():
	SceneTransition.reload_scene()


func _on_restart_button_pressed():
	SceneTransition.reload_scene()
