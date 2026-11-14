extends Control



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	


func _on_button_2_pressed() -> void:
		DialogueManager.show_example_dialogue_balloon(load("res://misc/dialogue/start.dialogue"))
