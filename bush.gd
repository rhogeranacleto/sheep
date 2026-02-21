extends Node2D
class_name Bush

const bush_scene = preload("uid://denti85gu4vsd")

static func instanciate() -> Bush:
	var bush = bush_scene.instantiate()
	
	return bush
