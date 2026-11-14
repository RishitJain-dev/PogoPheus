extends Control

@export var progress_bar: ProgressBar
@export var label: Label
func set_value(value):
	progress_bar.value = value

func set_text(text: String):
	label.text = text
