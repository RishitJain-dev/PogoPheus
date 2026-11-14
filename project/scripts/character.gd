extends CharacterBody2D

@export var spring_length: int = 100
@export var spring_constant: int = 3.5
@export var mass: int = 5

# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, Vector2(0, 10000))
	var result = space_state.intersect_ray(query)
	if result:
		var vertical_distance_to_obstacle = absi(result.position.y-self.position.y)
		if vertical_distance_to_obstacle <= spring_length:
			var upward_force = spring_constant * absi((vertical_distance_to_obstacle-spring_length)) #compression
			print("upward force: " + str(upward_force))
			print("gravity force:" + str(9.81*mass))
			var acceleration = upward_force/mass
			velocity.y -= acceleration
	velocity.y += 9.81
	print(velocity.y)
	move_and_slide()
