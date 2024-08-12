extends Node

var skin = "res://Textures/ship/ship_d/ship-d1.png"
var projectile_skin = "Bullet_e"
var high_score = 0
var Kill = 0

var paused = false 
var pauseable = false 
var Pause_Showing = false

signal game_paused
signal resume_pressed

var save_data:SaveData

func _ready():
	save_data = SaveData.load_or_create()
	save_data.save()
	skin = save_data.Ship_Skin
	projectile_skin = save_data.Bullets_Skin
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	resume_pressed.connect(reset_paused)
	
	
func _process(delta):
	if Input.is_action_just_pressed("Pause") && pauseable == true:
		game_paused.emit()
		PauseMenu()

func update_high_score():
	if save_data.high_score < Kill:
		save_data.high_score = Kill
		save_data.save()

func save_skins():
	save_data.Ship_Skin = skin
	save_data.Bullets_Skin = projectile_skin
	save_data.save()
	
func PauseMenu():
	if paused:
		get_tree().paused = false
		Pause_Showing = false
	else:
		get_tree().paused = true
		Pause_Showing = true
	paused = !paused
	
func reset_paused():
	get_tree().paused = false
	game_paused.emit()
	
func reset_Kill():
	Kill = 0
