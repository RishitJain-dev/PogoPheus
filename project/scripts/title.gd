extends Control



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	


func _on_button_2_pressed() -> void:
	$Layer.visible = false
	$CanvasLayer.visible = true
	DialogueManager.show_dialogue_balloon_scene("res://misc/dialogue/balloon.tscn", load("res://misc/dialogue/start.dialogue"))
	await DialogueManager.dialogue_ended
	$Layer.visible = true
	$CanvasLayer.visible = false
