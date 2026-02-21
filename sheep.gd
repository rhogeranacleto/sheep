extends Area2D

var hovered := false

@onready var sheep_sprite: Sprite2D = $SheepSprite
@onready var wool_growth_timer: Timer = $WoolGrowthTimer
@onready var wool_growth_progress: ProgressBar = $WoolGrowthProgress
@onready var eating_timer: Timer = $EatingTimer

signal sheared

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and hovered and wool_growth_progress.ratio == 1.0:
		shear()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_hovered.bind(true))
	mouse_exited.connect(_on_hovered.bind(false))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#wool_growth_progress.ratio = 1 - wool_growth_timer.time_left / wool_growth_timer.wait_time
	
	if get_overlapping_areas().is_empty():
		move_to_the_nearest_bush(delta)
		return
	
	if eating_timer.is_stopped():
		var first = get_overlapping_areas().get(0)
		
		eat(first)
	pass

func _on_hovered(is_hover: bool) -> void:
	hovered = is_hover
	
	sheep_sprite.modulate = Color(1.0, 0.733, 1.0) if is_hover else Color(1.0, 1.0, 1.0)

func shear() -> void:
	SignalBus.sheared.emit()
	wool_growth_progress.value = 0
	
func eat(bush_area: Area2D):
	bush_area.get_parent().queue_free()
	eating_timer.start()
	wool_growth_progress.ratio += 0.4

func move_to_the_nearest_bush(delta: float):
	var bushes = get_tree().get_nodes_in_group('bush')
	
	var nearest: Node2D = bushes.reduce(find_nearest_to_the_position.bind(global_position))
	
	global_position = global_position.move_toward(nearest.global_position, delta * 20)
	
	pass
	
func find_nearest_to_the_position(nearest: Node2D, current: Node2D, position: Vector2) -> Node2D:
	var nearest_distance = nearest.global_position.distance_to(position)
	var current_distance = current.global_position.distance_to(position)
	
	return nearest if nearest_distance < current_distance else current
