extends StaticBody2D

@export var crumble_delay: float = 0.5
@export var respawn_time: float = 3.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

var is_crumbling: bool = false


func _on_detect_area_body_entered(body: Node2D) -> void:
	if is_crumbling:
		return

	if not body.is_in_group("player"):
		return

	crumble()


func crumble() -> void:
	is_crumbling = true


	var tween := create_tween()
	tween.tween_property(sprite, "modulate:a", 0.0, crumble_delay)

	await get_tree().create_timer(crumble_delay).timeout

	
	collision.set_deferred("disabled", true)
	sprite.hide()


	await get_tree().create_timer(respawn_time).timeout

	collision.set_deferred("disabled", false)
	sprite.modulate.a = 1.0
	sprite.show()
	is_crumbling = false
