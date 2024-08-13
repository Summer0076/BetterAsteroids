extends Node

func _ready():
	%KillValue.text = str(Global.save_data.Kill)
	%HighScoreValue.text = str(Global.save_data.high_score)
	Global.reset_paused()

	
func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level/Level.tscn")
	Global.reset_Kill()
	
func _on_button_skin_pressed():
	get_tree().change_scene_to_file("res://Scenes/Skin/Skin.tscn")

func _on_button_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/Settings/Settings.tscn")

func _on_button_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/Credits/Credits.tscn")
	
func _on_button_quit_pressed():
	get_tree().quit()


