extends Node

@onready var highscore_value = $Control/HighscoreLabel/HighscoreValue

func _ready():
	highscore_value.text = str(Global.save_data.high_score)
	
func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level/Level.tscn")
	Global.reset_Kill()
	
func _on_button_skin_pressed():
	get_tree().change_scene_to_file("res://Scenes/Skin/Skin.tscn")
	
func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/Credits/Credits.tscn")
