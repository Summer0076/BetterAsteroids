extends Node

var skin = "res://Textures/ship/ship_d/ship-d1.png"
var projectile_skin = "Bullet_e"
var high_score = 0
var Kill = 0

var save_data:SaveData

func _ready():
	save_data = SaveData.load_or_create()
	save_data.save()
	skin = save_data.Ship_Skin
	projectile_skin = save_data.Bullets_Skin
	
func update_high_score():
	if save_data.high_score < Kill:
		save_data.high_score = Kill
		save_data.save()

func save_skins():
	save_data.Ship_Skin = skin
	save_data.Bullets_Skin = projectile_skin
	save_data.save()
	
func reset_Kill():
	Kill = 0
