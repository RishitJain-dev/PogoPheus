extends StaticBody2D

@export var is_red := true

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	ToggleState.changed.connect(_update)
	_update(ToggleState.red_active)


func _update(red_active: bool) -> void:
	var solid := (red_active == is_red)
	collision.set_deferred("disabled", not solid)
	sprite.modulate.a = 1.0 if solid else 0.25
