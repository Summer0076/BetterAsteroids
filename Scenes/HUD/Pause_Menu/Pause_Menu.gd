extends Control

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/HUD/Start_Menu/Start_Menu.tscn")


func _on_resume_button_pressed():
	Global.resume_pressed.emit()
