class_name SaveData extends Resource

@export var high_score:int = 0
@export var Kill:int = 0

@export var Ship_Skin = "res://Textures/ship/ship_d/ship-d1.png"
@export var Bullets_Skin = "Bullet_e"
@export var Volume_Music:float = -14.4
@export var Volume_Env:float = -14.4

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
