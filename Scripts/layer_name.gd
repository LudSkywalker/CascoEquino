extends MarginContainer
class_name LayerName

@onready var label: Label = %Label
@onready var timer: Timer = %Timer
@export var visual_font_size: int = 23

var layer_name: String = ""
var font_size = 0

func _process(_delta):
	if layer_name != "":
		self.visible = true
		if label.text != layer_name:
			label.text = layer_name
	else:
		self.visible = false

func _on_label_resized() -> void:
	font_size = (visual_font_size * 4.0 / DisplayServer.window_get_size().x + visual_font_size * 0.25 / DisplayServer.window_get_size().y) * 700.0
	if label:
		label.add_theme_font_size_override("font_size", int(font_size))


func _on_timer_timeout() -> void:
	pass # Replace with function body.