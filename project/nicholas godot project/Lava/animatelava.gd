extends AnimatedSprite2D


func _ready():
	frame = randi() % sprite_frames.get_frame_count("default")
	speed_scale = randf_range(0.8, 1.2)
	play("default")
