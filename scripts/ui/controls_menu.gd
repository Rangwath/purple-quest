extends Control

@onready var focus_button = $MainMenuButton


func _ready():
	focus_button.grab_focus()


func _on_main_menu_button_pressed():
	SceneTransition.load_main_menu_scene()
