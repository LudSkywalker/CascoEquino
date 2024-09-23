extends HBoxContainer
class_name VisibilityTogle

@onready var label: Label = %Label
@onready var check_box: CheckBox = %CheckBox

@export var layer_node: MeshInstance3D = null
@export var visual_font_size: int = 23

var font_size = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = layer_node.name.split("_")[1]


func _on_check_box_toggled(toggled_on: bool) -> void:
	layer_node.visible = toggled_on
	var waiting: Array[Node] = layer_node.get_children()
	while len(waiting) > 0:
		var child: Node = waiting.pop_back()
		waiting.append_array(child.get_children())
		# child.visible = toggled_on
		if child is CollisionShape3D:
			child.disabled = !toggled_on


func _on_label_resized() -> void:
	font_size = (visual_font_size * 4.0 / DisplayServer.window_get_size().x + visual_font_size * 0.25 / DisplayServer.window_get_size().y) * 700.0
	if label:
		label.add_theme_font_size_override("font_size", int(font_size))
	if check_box:
		check_box.add_theme_constant_override("icon_max_width", font_size * 1.6)