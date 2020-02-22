extends CanvasLayer

const TYPE = preload("res://Money/Type.gd")

var coins := []
onready var objective_input := $VBoxContainer/ObjectiveContainer/ObjectiveControl/ObjectiveInput

func _ready() -> void:
	pass # Replace with function body.

func _on_PlayButton_pressed() -> void:
	$VBoxContainer/MarginContainer/ButtonAudio.play()
	print("Play Button pressed!")
	# check value was typed
	var objective_string = objective_input.text.replace(",", ".") #support italian style
	
	var objective: = float(objective_string)
	
	if objective == 0:
		return #show alert
	
	#get info about coins (two columns)
	for control in $VBoxContainer/MoneyContainer/MoneyControls/Left.get_children():
		if not control.is_in_group("coin_control"):
			continue
		extract_money(control)
	for control in $VBoxContainer/MoneyContainer/MoneyControls/Right.get_children():
		if not control.is_in_group("coin_control"):
			continue
		extract_money(control)
	# add check to see if a solution is avaiable
	
	Global.coins = coins
	Global.objective = objective
	
	get_tree().change_scene("res://Game/Game.tscn")



func extract_money(control: CoinSelector) -> void:
	var type: int = control.get_type()
	var count: int = control.get_coin_count()
	for _i in range(count):
		coins.append(type)
