extends Node
class_name Helpers

static func find_nearest_to_the_position(nearest: Node2D, current: Node2D, global_position: Vector2) -> Node2D:
	var nearest_distance = nearest.global_position.distance_to(global_position)
	var current_distance = current.global_position.distance_to(global_position)
	
	return nearest if nearest_distance < current_distance else current
