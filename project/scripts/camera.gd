extends Camera2D
@export var character: CharacterBody2D

#func _physics_process(delta: float) -> void:
	#await get_tree().create_timer(0.5).timeout
	#var velocity: Vector2 = Vector2.ZERO
	#await $Character.physics_processed
	#velocity.x = move_toward(position.x, character.position.x, 60)
	#position += velocity
	
