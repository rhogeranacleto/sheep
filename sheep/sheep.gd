extends Node2D

@onready var clickable_area: Area2D = $BodySprite/Torso/Area2D
@onready var body_sprite: Node2D = $BodySprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bush_feeding_area: Area2D = $BushFeedingArea
@onready var line_2d: Line2D = $Line2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const wool_grow = [0.8, 1.8]

var hovered := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and hovered:
		shear()
		
func _ready() -> void:
	clickable_area.mouse_entered.connect(_on_hovered.bind(true))
	clickable_area.mouse_exited.connect(_on_hovered.bind(false))

func _process(delta: float) -> void:
	if animation_player.current_animation == 'eat':
		return
	
	if bush_feeding_area.get_overlapping_areas().is_empty():
		var bushes = get_tree().get_nodes_in_group('bush')
	
		var nearest: Node2D = bushes.reduce(Helpers.find_nearest_to_the_position.bind(bush_feeding_area.global_position))
		
		var target_destination = nearest.global_position - (bush_feeding_area.global_position - global_position)
		
		line_2d.set_point_position(1, to_local(nearest.global_position))
		print (target_destination)
		global_position = global_position.move_toward(target_destination, delta * 20)
		return
	
	if not animation_player.is_playing():
		var first = bush_feeding_area.get_overlapping_areas().get(0)
		
		eat(first)
	
	pass

func eat(bush_area: Area2D):
	bush_area.get_parent().queue_free()
	animation_player.play('eat')
	pass

func _on_hovered(is_hover: bool) -> void:
	hovered = is_hover
	
	body_sprite.modulate = Color(1.0, 0.886, 1.0, 1.0) if is_hover else Color(1.0, 1.0, 1.0)

func shear() -> void:
	SignalBus.sheared.emit()
	
