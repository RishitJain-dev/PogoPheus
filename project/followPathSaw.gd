extends PathFollow2D

@export var speed: float = 0.2 # Moves 20% of the path per second

var direction: int = 1

func _process(delta: float) -> void:
	progress_ratio += speed * direction * delta

	if progress_ratio >= 1.0:
		progress_ratio = 1.0
		direction = -1
	elif progress_ratio <= 0.0:
		progress_ratio = 0.0
		direction = 1
