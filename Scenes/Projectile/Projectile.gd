extends Node2D
class_name Projectile


@export var speed = 400

@onready var direction := Vector2.RIGHT.rotated(rotation)
@onready var sprite_2d = $Sprite2D


func _ready():
	sprite_2d.play(Global.projectile_skin)

func _physics_process(delta) -> void:
	# delta = projectile deplace même vitesse peu importe puissance l'ordinateur
	var velocity = direction * speed * delta
	global_position += velocity
	
	
func _on_area_entered(area : Area2D) -> void:
	if area is Asteroid:
		area.destroy()
		queue_free()

func destroy():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
