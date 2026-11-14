extends CharacterBody2D

@export var spring_length: int = 100
@export var spring_constant: int = 7
@export var mass: int = 5
@export var movement_speed: float = 40
@export var max_speed: float = 900
@export var progress_bar: Control
var initial_position
var jump_charge_progress: int = 0
signal physics_processed
var kill_count: int = 0


func _ready() -> void:
	initial_position  = position
func is_positive(num: int) ->bool:
	return num >= 0

func set_deaths_counter(deaths: int) -> void:
	if deaths == 0:
		progress_bar.set_text("Still Surviving")
	elif deaths == 1:
		progress_bar.set_text("1 Death")
	else:
		progress_bar.set_text(str(deaths) + " Deaths")
func _physics_process(delta: float) -> void:
	#y axis
	var velocity_initial: int = velocity.y
	#basic pogo bouncing
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, Vector2(0, 10000))
	var result = space_state.intersect_ray(query)
	if result:
		var vertical_distance_to_obstacle = absi(result.position.y-self.position.y)
		if vertical_distance_to_obstacle <= spring_length:
			var upward_force = spring_constant * absi((vertical_distance_to_obstacle-spring_length)) #compression
			var acceleration = cos(rotation)*upward_force/mass
			velocity.y -= acceleration

		# emergency-check
			#if abs(vertical_distance_to_obstacle-spring_length) < 0.1:
				#velocity.y = -5
		
	velocity.y += 9.81 # gravity
	if velocity.y > max_speed:
		velocity.y = max_speed
	elif velocity.y < -max_speed:
		velocity.y = -max_speed
	# x axis
	
	
	var control: float = Input.get_axis('motion_left', 'motion_right')
	rotation_degrees += 10*control*delta
	if absi(rotation_degrees) >= 15:
		if rotation_degrees > 0:
			rotation_degrees = 15
		else:
			rotation_degrees = -15
	rotation_degrees = move_toward(rotation_degrees, 0, 3*delta)
	
	velocity.x = sin(rotation) * 400 * delta * movement_speed
	if absi(velocity.x) >= 50:
		velocity.x = move_toward(velocity.x, 0, 5)
	if velocity.x > max_speed:
		velocity.x = max_speed
		
	if Input.is_action_pressed("space"):
		jump_charge_progress += 1
	else:
		jump_charge_progress -= 3
		if jump_charge_progress < 0:
			jump_charge_progress = 0
	progress_bar.set_value(jump_charge_progress)
	
	if !is_positive(velocity.y) and is_positive(velocity_initial): #changing from moving down to up
		if !Input.is_action_pressed("space") and jump_charge_progress!=0:
			velocity.y *= sqrt(2*jump_charge_progress)
		jump_charge_progress = 0
	
	

	#if velocity.x >= 0:
		#velocity.x = velocity.x / 1.5
		#velocity.x += control * movement_speed
		#if velocity.x > max_speed:
			#velocity.x = max_speed
	#if velocity.x < 0:
		#velocity.x = velocity.x / 1.5
		#velocity.x += control * movement_speed
		#if velocity.x < -max_speed:
			#velocity.x = -max_speed
	move_and_slide()
	physics_processed.emit()

func kill() -> void:
	kill_count += 1
	set_deaths_counter(kill_count)
	position = initial_position
	velocity = Vector2.ZERO
