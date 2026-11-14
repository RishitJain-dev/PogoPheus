extends Node2D

func _ready() -> void:
	for child in get_children():
		if child is AnimatedSprite2D:
			child.play()

func _process(delta: float) -> void:
	if !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.play(0)
