extends Node

const TYPE = preload("res://Money/Type.gd")
export (PackedScene) var Money
export var objective: float = 0.0

onready var hud = $HUD

var wallet_content: = 0.0
var held_object: Money
var is_active := true # used to enable-disable game (eg when winning)

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(self,"ready")
	level_setup(Global.objective, Global.coins)
	$CanvasLayer/AcceptDialog.visible = false
	is_active = true
	held_object = null
	pass # Replace with function body.

func level_setup(_objective: float, coins: Array):
	objective = _objective
	hud.update_objective(objective)
	hud.update_score(wallet_content)
	var screensize = get_viewport().get_visible_rect().size
	for m in coins:
		var coin = Money.instance()
		coin.set_type(m)
		randomize()
		coin.position = Vector2(rand_range(0, screensize.x), rand_range(screensize.y/2, screensize.y))
		coin.add_to_group("money")
		coin.connect("clicked", self, "_on_pickable_clicked")
		$Money.add_child(coin)

func _on_pickable_clicked(object) -> void:
	if ! held_object and is_active:
		held_object = object
		object.pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop()
			held_object = null

func _on_Wallet_area_entered(area):
	if area.is_in_group("money"):
		wallet_content += area.money_value
		hud.update_score(wallet_content)
		#check_game()

func _on_Wallet_area_exited(area):
	if area.is_in_group("money"):
		wallet_content -= area.money_value
		hud.update_score(wallet_content)
		#check_game()

func level_win() -> void:
	#wait 1-2 seconds (?) - sound makes it evident
	is_active = false #disable picking
	$WinSound.play()
	$CanvasLayer/AcceptDialog.visible = true

func check_game() -> void:
	var wallet = str(wallet_content) #I use strings to avoid error sin aproximation
	var obj =  str(objective)
	
	if wallet == obj: #wallet_content == objective:
		level_win()
	elif wallet_content > objective:
		error_sound()

func error_sound():
	randomize()
	var sound_idx = randi() % 5 
	var player: AudioStreamPlayer = $Sounds.get_child(sound_idx)
	player.play()

func _on_AcceptDialog_confirmed() -> void:
	get_tree().change_scene("res://GUI/StartScreen.tscn")

func _on_PayButton_pressed() -> void:
	check_game()
