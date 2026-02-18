extends Area2D

var hovered := false

@onready var sheep_sprite: Sprite2D = $SheepSprite
@onready var wool_growth_timer: Timer = $WoolGrowthTimer
@onready var wool_growth_progress: ProgressBar = $WoolGrowthProgress

signal sheared

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") and hovered and wool_growth_timer.is_stopped():
		shear()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_entered.connect(_on_hovered.bind(true))
	mouse_exited.connect(_on_hovered.bind(false))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wool_growth_progress.ratio = 1 - wool_growth_timer.time_left / wool_growth_timer.wait_time
	pass

func _on_hovered(is_hover: bool) -> void:
	hovered = is_hover
	
	sheep_sprite.modulate = Color(1.0, 0.733, 1.0) if is_hover else Color(1.0, 1.0, 1.0)

func shear() -> void:
	SignalBus.sheared.emit()
	wool_growth_timer.start()
