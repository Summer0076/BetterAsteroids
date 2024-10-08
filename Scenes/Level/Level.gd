extends Node
class_name Level

var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var screen_size = Vector2(screen_width, screen_height) 

var paused = false 


@onready var asteroids_container : Node2D = %Asteroids
@onready var border_rect = %BorderRect
@onready var gameover = %Gameover
@onready var asteroid_timer = $Asteroids/SpawnTimer
@onready var in_game = $InGame
@onready var player = $Player
@onready var pause_layer = $PauseLayer

@export var asteroid_scene : PackedScene
@export var spawn_circle_radius : float = 350.0
@export var asteroid_direction_variance = 45.0

func _ready():
	Global.game_paused.connect(_on_game_paused)

func spawn_asteroid_on_border() -> void:
	var screen_center = screen_size / 2.0 
	var angle = deg_to_rad(randf_range(0.0, 360.0))
	
	var dir_to_point = Vector2.RIGHT.rotated(angle)
	var point = screen_center + dir_to_point * spawn_circle_radius
	
	var top_left = border_rect.global_position
	var bottom_right = border_rect.global_position + border_rect.size
	
	point = point.clamp(top_left, bottom_right)


	var dir_to_center = point.direction_to(screen_center)
	
	var dir_rotation = randfn(0.0, deg_to_rad(asteroid_direction_variance))
	var asteroid_dir = dir_to_center.rotated(dir_rotation)
	var asteroid_size =  randi_range(0, Asteroid.SIZE.size() - 1)
	spawn_asteroid(point, asteroid_dir, asteroid_size)

func spawn_asteroid(pos:Vector2, dir: Vector2, size: Asteroid.SIZE) -> void:
	var asteroid = asteroid_scene.instantiate()
	asteroids_container.add_child.call_deferred(asteroid)
	
	asteroid.position = pos
	asteroid.direction = dir

	asteroid.size = size
	#Determine la taille de l'asteroid
	asteroid.destroyed.connect(_on_asteroid_destroyed.bind(asteroid))

func _on_asteroid_destroyed(asteroid: Asteroid) -> void:
	Global.Kill += 1
	
	#Spawn des plus petits asteroids apres une destruction
	if asteroid.size > 0:
		var nb_spawn = randi_range(2, 3)
		
		for i in range(nb_spawn):
			var rot_deg = 90.0 + randfn(0.0, deg_to_rad(asteroid_direction_variance))
			#Permet de choisir un signe aleatoire
			var rdm_sign = [-1 , 1].pick_random()
			var rot = deg_to_rad(rot_deg * rdm_sign)
			
			var dir = asteroid.direction.rotated(rot)
			
			spawn_asteroid(asteroid.global_position, dir, asteroid.size - 1)

func _on_spawn_timer_timeout() -> void:
	spawn_asteroid_on_border()

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	Global.reset_Kill()
	Global.reset_paused() 
	
func _on_player_destroyed() -> void:
	gameover.show()
	in_game.stop_score_timer()
	Global.update_Kill_score()
	Global.update_high_score()
	
func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/HUD/Start_Menu/Start_Menu.tscn")
	Global.reset_Kill()

func _on_game_paused():
	if Global.Pause_Showing == false:
		pause_layer.show()
	else:
		pause_layer.hide()
	
