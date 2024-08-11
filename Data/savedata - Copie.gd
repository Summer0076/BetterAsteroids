class_name SaveData extends Resource

@export var high_score:int = 0
@export var Ship_Skin = "res://Textures/ship/ship_d/ship-d1.png"
@export var Bullets_Skin = "Bullet_e"


const SAVE_PATH:String = "user://save_data.tres" 

func save() -> void:
	ResourceSaver.save(self, SAVE_PATH)

static  func load_or_create() -> SaveData:
	var res:SaveData
	if FileAccess.file_exists(SAVE_PATH):
		res = load(SAVE_PATH) as SaveData
	else:
		res = SaveData.new()
	return res
