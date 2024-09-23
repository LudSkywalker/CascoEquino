extends Node3D

@onready var casco_equino: Node3D = %cascoEquino
@onready var ui: UI = %UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var layers_dic = {}
	for layer_node in casco_equino.get_children():
		layers_dic[layer_node.name] = layer_node

	var layer_names = layers_dic.keys()
	layer_names.sort_custom(func(a: String, b: String): return int(a.split("_")[0]) < int(b.split("_")[0]))
	print(layer_names)

	for layer_name in layer_names:
		ui.add_layer(layers_dic[layer_name])
