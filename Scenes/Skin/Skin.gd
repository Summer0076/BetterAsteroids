extends Node

var skin_array = [
	"res://Textures/ship/ship-a/ship-a1_2.png",
	"res://Textures/ship/ship-b/ship-b1.png",
	"res://Textures/ship/ship-c/ship-c1.png",
	"res://Textures/ship/ship_d/ship-d1.png",
	"res://Textures/ship/ship_e/ship-e1.png",
	"res://Textures/ship/ship_f/ship-f1.png",
]

var skin_projectile_array = [
	"Bullet_a",
	"Bullet_b",
	"Bullet_c",
	"Bullet_d",
	"Bullet_e",
	"Bullet_f",
]

func _ready():
	Global.pauseable = false
	

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/HUD/Start_Menu/Start_Menu.tscn")


func _on_ship_button_item_selected(index):
	Global.skin = skin_array[index]
	var Global_url = Global.skin
	var TheSkin = load(Global_url)
	%Sprite2D_Ship.texture = TheSkin
	Global.save_skins()
	
func _on_bullet_button_item_selected(index):
	Global.projectile_skin = skin_projectile_array[index]
	%Sprite2D_Bullets.play(Global.projectile_skin)
	Global.save_skins()
