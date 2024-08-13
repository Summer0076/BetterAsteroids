extends CharacterBody2D
class_name Player


@export var max_speed :float = 250.0
@export var projectile_scene : PackedScene 
@export var teleport_distance = 100
@export var bCanFire = true
@export var bCanDash = true

@export_range(0.0,1.0) var lerp_velocity : float = 0.1
@export_range(0.0,1.0) var lerp_rotation : float = 0.1

@onready var SpawnProjectile = $SpawnProjectile
@onready var Sprite = $Sprite2D
@onready var dash_timer = $DashTimer

@onready var Global_url = Global.skin
@onready var TheSkin = load(Global_url)

var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var screen_size = Vector2(screen_width, screen_height)
 
var current_speed : float = 0.0
var direction = Vector2.ZERO
var last_direction = Vector2.ZERO

signal projectile_fired(projectile)
signal destroyed

func _ready():
	Sprite.texture = load(Global.skin)
	$Fire_sound.volume_db = Global.Env_Volume

func Input_Movements() -> void:
	direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction != Vector2.ZERO:
		last_direction = direction
	
	if direction == Vector2.ZERO:
		current_speed = lerp(current_speed, 0.0, lerp_velocity)
	else:
		current_speed = lerp(current_speed, max_speed, lerp_velocity)
		
	velocity = last_direction * current_speed
	
	if Input.is_action_just_pressed("Shoot"):
		fire()
		
	if Input.is_action_just_pressed("Dash"):
		dashing()

func fire() -> void:
	if bCanFire == true:
		$Fire_sound.play()
		var projectile = projectile_scene.instantiate()
		projectile.position = SpawnProjectile.global_position
		projectile.rotation = rotation
		projectile_fired.emit(projectile)

func dashing():
	if bCanDash == true:
		var mouse_pos = get_global_mouse_position()
		var player_pos = global_position
	
		# Calcul de la direction unitaire vers la souris
		var direction_to_mouse = (mouse_pos - player_pos).normalized()
	
		# Calculer le déplacement dans cette direction
		var move_vector = direction_to_mouse * teleport_distance
	
		var new_position = player_pos + move_vector
		global_position = new_position
		dash_timer.start()
		bCanDash = false

func rotate_ship() -> void:
	var mouse_pos = get_global_mouse_position()
	var angle = global_position.angle_to_point(mouse_pos)
	rotation = lerp_angle(rotation, angle, lerp_rotation)

func _physics_process(_delta) -> void:
	Input_Movements()
	rotate_ship()
	move_and_slide()

	global_position = global_position.clamp(Vector2.ZERO,screen_size)

func destroy() -> void:
	destroyed.emit()
	queue_free()
	
func _on_dash_timer_timeout():
	bCanDash = true
