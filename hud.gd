extends Control

@onready var wool_value: Label = $Container/WoolValue

var wool_amount := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.sheared.connect(update_wool)

func update_wool() -> void:
	wool_amount += 1
	wool_value.text = str(wool_amount)
