extends Control
class_name UI

signal clip_limb(toggled_on: bool)
signal hover_menu(hover: bool)

@onready var layers: VBoxContainer = %Layers
@onready var label: Label = %Label
@onready var check_box: CheckBox = %CheckBox
@onready var timer: Timer = %Timer

@export var visibility_togle_scene: PackedScene
@export var visual_font_size: int = 23
var full_screen: bool = false
var font_size = 0

# Called when the node enters the scene tree for the first time.
func add_layer(layer_node: Node3D) -> void:
	var visibility_togle: VisibilityTogle = visibility_togle_scene.instantiate()
	visibility_togle.layer_node = layer_node
	layers.add_child(visibility_togle)

func _on_texture_button_pressed() -> void:
	if !full_screen:
		full_screen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		full_screen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_label_resized() -> void:
	font_size = (visual_font_size * 3.0 / DisplayServer.window_get_size().x + visual_font_size * 0.5 / DisplayServer.window_get_size().y) * 700.0
	if label:
		label.add_theme_font_size_override("font_size", int(font_size))
	if check_box:
		check_box.add_theme_constant_override("icon_max_width", font_size * 1.6)


func _on_check_box_toggled(toggled_on: bool) -> void:
	clip_limb.emit(toggled_on)


func _on_layers_container_mouse_entered() -> void:
	hover_menu.emit(true)


func _on_layers_container_mouse_exited() -> void:
	hover_menu.emit(false)
	
