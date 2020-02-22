extends Area2D
class_name Money

const TYPE = preload("res://Money/Type.gd")
signal clicked
var held: = false
var front_textures = {
	'cent_1': "res://assets/sprites/front/cent_1.png",
	'cent_2': "res://assets/sprites/front/cent_2.png",
	'cent_5': "res://assets/sprites/front/cent_5.png",
	'cent_10': "res://assets/sprites/front/cent_10.png",
	'cent_20': "res://assets/sprites/front/cent_20.png",
	'cent_50': "res://assets/sprites/front/cent_50.png",
	'eur_1': "res://assets/sprites/front/eur_1.png",
	'eur_2': "res://assets/sprites/front/eur_2.png"
}

var back_textures = {
	'cent_1': "res://assets/sprites/back/cent_1.png",
	'cent_2': "res://assets/sprites/back/cent_2.png",
	'cent_5': "res://assets/sprites/back/cent_5.png",
	'cent_10': "res://assets/sprites/back/cent_10.png",
	'cent_20': "res://assets/sprites/back/cent_20.png",
	'cent_50': "res://assets/sprites/back/cent_50.png",
	'eur_1': "res://assets/sprites/back/eur_1.png",
	'eur_2': "res://assets/sprites/back/eur_2.png"
}

var type setget set_type

var money_value: float

func _ready():
	$Front.visible = true
	$Back.visible = false
	pass # Replace with function body.

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)
		elif event.button_index == BUTTON_RIGHT and event.pressed:
			flip()

func _process(delta: float) -> void:
	if held:
		global_position = get_global_mouse_position()

func pickup() -> void:
	if held:
		return
	held = true

func drop() -> void:
	if held:
		held = false

func flip() -> void:
	$Front.visible = not $Front.visible
	$Back.visible = not $Back.visible
	#add Tween animation and sound

func set_type(value) -> void:
	type = value
	var texture_name = 'eur_1'
	#load textures
	match type:
		TYPE.CENT_1:
			texture_name = 'cent_1'
			money_value = 0.01
		TYPE.CENT_2:
			texture_name = 'cent_2'
			money_value = 0.02
		TYPE.CENT_5:
			texture_name = 'cent_5'
			money_value = 0.05
		TYPE.CENT_10:
			texture_name = 'cent_10'
			money_value = 0.10
		TYPE.CENT_20:
			texture_name = 'cent_20'
			money_value = 0.20
		TYPE.CENT_50:
			texture_name = 'cent_50'
			money_value = 0.50
		TYPE.EUR_1:
			texture_name = 'eur_1'
			money_value = 1.0
		TYPE.EUR_2:
			texture_name = 'eur_2'
			money_value = 2.0
	
	$Front.texture = load(front_textures[texture_name])
	$Back.texture = load(back_textures[texture_name])
	pass
