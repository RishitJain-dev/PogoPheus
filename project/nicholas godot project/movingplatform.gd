extends AnimatableBody2D

@export var move_offset := Vector2(200, 0)
@export var duration := 2.0

func _ready() -> void:
	var start_position := position
	var end_position := position + move_offset

	var tween := create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", end_position, duration)
	tween.tween_property(self, "position", start_position, duration)
