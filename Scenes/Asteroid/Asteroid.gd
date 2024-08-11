@tool
extends Area2D
class_name Asteroid

var direction := Vector2.RIGHT

enum SIZE {
	SMALL,
	MEDIUM,
	BIG,
}

@onready var sprite : Sprite2D = $Sprite2D
@onready var collision_shape_2d : CollisionShape2D = $CollisionShape2D

@export var speed = 200.0
@export var torque = 50.0


@export var asteroid_size_array : Array[AsteroidSize]


@export var size : SIZE = SIZE.BIG:
	set(value):
		if value != size:
			size = value
			size_changed.emit()
			

signal size_changed
signal destroyed

func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)
		
	size_changed.connect(update_size)
	
	update_size()


func _physics_process(delta : float) -> void:
	var velocity = speed * direction * delta
	global_position += velocity
	
	rotation_degrees += torque * delta

func update_size() -> void:
	if not size in range(asteroid_size_array.size()):
		push_error("The given size " + str(size) + " isn't a valide asteroid size index, essaye d'indexer une valeur qui n'existe pas")
	
	var asteroid_size = asteroid_size_array[size]
	
	sprite.texture = asteroid_size.texture
	collision_shape_2d.shape = asteroid_size.shape

func destroy() -> void:
	destroyed.emit()
	queue_free()


func _on_body_entered(body : Player):
	body.destroy()
