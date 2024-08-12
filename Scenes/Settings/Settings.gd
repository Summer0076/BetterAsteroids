extends Control

#Buttons
func mask_all_background():
	$KeybindsBackgroud.hide()
	$AudioBackground.hide()
	$VideoBackground.hide()

func _on_keybinds_button_pressed():
	mask_all_background()
	$KeybindsBackgroud.show()

func _on_audio_button_pressed():
	mask_all_background()
	$AudioBackground.show()

func _on_video_button_pressed():
	mask_all_background()
	$VideoBackground.show()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/HUD/Start_Menu/Start_Menu.tscn")

