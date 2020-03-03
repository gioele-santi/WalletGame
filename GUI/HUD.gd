extends CanvasLayer
class_name HUD

onready var objective_lbl = $MarginContainer/VBoxContainer/ObjectiveLabel
onready var score_lbl = $MarginContainer/VBoxContainer/CurrentValueLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func update_objective(value: float) -> void:
	objective_lbl.text = str(value).replace(".", ",") + " €"

func update_score(value: float) -> void:
	score_lbl.text = str(value).replace(".", ",") + " €"
