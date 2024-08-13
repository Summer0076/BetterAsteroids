extends Control


#Buttons
func mask_all_background():
	$KeybindsBackgroud.hide()
	$AudioBackground.hide()

func _on_keybinds_button_pressed():
	mask_all_background()
	$KeybindsBackgroud.show()

func _on_audio_button_pressed():
	mask_all_background()
	$AudioBackground.show()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/HUD/Start_Menu/Start_Menu.tscn")


func _on_h_slider_value_changed(value):
	if value == 0:
		Global.Music_Volume = -99999
	else:
		var Volume = lerp(-40.0, -14.4, value / 100.0)
		Global.Music_Volume = Volume
	%Label_Music_Value.text = str(value)



func _on_h_slider_env_value_changed(value):
	if value == 0:
		Global.Env_Volume = -99999
	else:
		var Volume = lerp(-40.0, -14.4, value / 100.0)
		Global.Env_Volume = Volume
		%Label_Env_Value.text = str(value)
