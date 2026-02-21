@tool
extends TileMapLayer

@export_tool_button('Generate') var generate_action = generate_grass
@export var tilesize := Vector2i(20, 20)

const tile_id = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_grass()
	pass # Replace with function body.

func generate_grass() -> void:
	clear()
	for x in range(tilesize.x):
		for y in range(tilesize.y):
			if randf() < 0.3:
				set_cell(Vector2(x, y), 2, Vector2.ZERO)
	
	
