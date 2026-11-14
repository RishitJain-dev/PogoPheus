extends CharacterBody2D

@export var spring_length: int = 100
@export var spring_constant: int = 1000
@export var mass: int = 5


# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(Vector2(0, 0), Vector2(0, 100))
	var result = space_state.intersect_ray(query)
	if result:
		var vertical_distance_to_obstacle = absi(result.position.y-position.y)
		if vertical_distance_to_obstacle <= spring_length:
			var upward_force = spring_constant * (100-spring_length) #compression
			var acceleration = upward_force/mass
			velocity.y -= acceleration
	velocity.y += mass * 9.81
	print(velocity.y)
	move_and_slide()
