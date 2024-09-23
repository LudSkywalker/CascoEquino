extends Node3D

@onready var camera: Camera3D = $Camera

@export var layer_name_path: PackedScene

var hover_menu: bool = false
var rotation_clicked: bool = false
var cliped_clicked: bool = false
var word_space
var label_piece: LayerName

func _ready():
	word_space = get_world_3d().direct_space_state
	label_piece = layer_name_path.instantiate()
	self.add_child(label_piece)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton && !hover_menu:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			rotation_clicked = true
		else:
			rotation_clicked = false
	if (event is InputEventMouseMotion || event is InputEventScreenTouch) && !hover_menu:
		if !cliped_clicked && rotation_clicked:
			rotate_object_local(Vector3.UP, event.relative.x * -0.01)
			rotate_object_local(Vector3.FORWARD, event.relative.y * -0.005)
			if label_piece.layer_name != "":
				label_piece.layer_name = ""
		else:
			var mouse = event.position
			var start = camera.project_ray_origin(mouse)
			var end = camera.project_position(mouse, camera.position.x * 2.5)
			if cliped_clicked:
				start = camera.project_position(mouse, camera.position.x - 0.05)
			var parameters = PhysicsRayQueryParameters3D.create(start, end)
			var result = word_space.intersect_ray(parameters)
			if result:
				var col: Node = result["collider"]
				label_piece.position = mouse
				var layer_name = col.get_parent().name.split("_")[1]
				if label_piece.layer_name != layer_name:
					label_piece.layer_name = layer_name
			elif label_piece.layer_name != "":
				label_piece.layer_name = ""


func _on_ui_clip_limb(cliped: bool) -> void:
	if cliped:
		self.rotation = Vector3(0, 0, 0)
		camera.near = camera.position.x
		cliped_clicked = true
	else:
		camera.near = 0.1
		cliped_clicked = false


func _on_ui_hover_menu(hover: bool) -> void:
	# print(hover)
	hover_menu = hover
