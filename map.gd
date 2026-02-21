extends Node2D

@onready var grass: TileMapLayer = $Grass
@onready var floor: TileMapLayer = $Floor

func _ready() -> void:
	randomize_bush()


func get_closes_grass_to_vector(pos: Vector2) -> Vector2:
	var map_position = grass.local_to_map(to_local(pos))
	
	for r in range(20):
		for x in range(-r, r + 1):
			for y in range(-r, r + 1):
				if abs(x) == r or abs(y) == r:
					var current_cell = map_position + Vector2i(x, y)
					
					if grass.get_cell_source_id(current_cell) >= 0:
						return to_global(grass.map_to_local(current_cell) + (grass.tile_set.tile_size / 2.0))

	return pos

func randomize_bush():
	for i in range(100):
		var bush = Bush.instanciate()
		
		var used_rect = floor.get_used_rect()
		var x = randi_range(used_rect.position.x, used_rect.position.x + (used_rect.size.x * floor.tile_set.tile_size.x) -1)
		var y = randi_range(used_rect.position.y, used_rect.position.y + (used_rect.size.y * floor.tile_set.tile_size.y) -1)
		var position = Vector2(x, y)
		
		bush.global_position = position
		
		add_child(bush)
	
