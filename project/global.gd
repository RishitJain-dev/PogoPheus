extends Node2D

@export var use_timer := true
@export var cycle_time := 2.0
@export var timer: Timer
@export var switch: Area2D

var red_active := true


func _ready() -> void:
	timer.wait_time = cycle_time
	timer.timeout.connect(toggle)
	switch.body_entered.connect(_on_switch_body_entered)

	if use_timer:
		timer.start()

	_apply_state()


func toggle() -> void:
	red_active = not red_active
	_apply_state()


func _on_switch_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		toggle()


func _apply_state() -> void:
	for block in get_tree().get_nodes_in_group("red_blocks"):
		_set_block_solid(block, red_active)

	for block in get_tree().get_nodes_in_group("blue_blocks"):
		_set_block_solid(block, not red_active)

func _set_block_solid(block: StaticBody2D, solid: bool) -> void:
	block.modulate.a = 1.0 if solid else 0.25

	for child in block.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", not solid)
