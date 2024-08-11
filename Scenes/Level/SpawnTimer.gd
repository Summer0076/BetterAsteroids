extends Timer

@export var reduction_amout = 0.005
@export var minimum_time = 0.2

func _on_timeout():
	if wait_time > minimum_time:
		wait_time = max(wait_time - reduction_amout, minimum_time)
