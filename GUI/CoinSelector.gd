extends MarginContainer

class_name CoinSelector

#const TYPE = preload("res://Money/Type.gd")
enum TYPE {CENT_1, CENT_2, CENT_5, CENT_10, CENT_20, CENT_50, EUR_1, EUR_2}

export (TYPE) var type := TYPE.CENT_1
var coin_count := 0 setget set_coin_count, get_coin_count
signal coin_count_changed(type, count)

onready var count_label = $HBoxContainer/CountCont/CountLabel
onready var name_label = $HBoxContainer/NameCont/CoinName
onready var texture_rect = $HBoxContainer/TextureRect

var gui_textures = {
	'cent_1': "res://assets/sprites/GUI/cent_1.png",
	'cent_2': "res://assets/sprites/GUI/cent_2.png",
	'cent_5': "res://assets/sprites/GUI/cent_5.png",
	'cent_10': "res://assets/sprites/GUI/cent_10.png",
	'cent_20': "res://assets/sprites/GUI/cent_20.png",
	'cent_50': "res://assets/sprites/GUI/cent_50.png",
	'eur_1': "res://assets/sprites/GUI/eur_1.png",
	'eur_2': "res://assets/sprites/GUI/eur_2.png"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.coin_count = 0
	var texture_name := ""
	var label : = ""
	match type:
		TYPE.CENT_1:
			texture_name = 'cent_1'
			label = "1 centesimo"
		TYPE.CENT_2:
			texture_name = 'cent_2'
			label = "2 centesimi"
		TYPE.CENT_5:
			texture_name = 'cent_5'
			label = "5 centesimi"
		TYPE.CENT_10:
			texture_name = 'cent_10'
			label = "10 centesimi"
		TYPE.CENT_20:
			texture_name = 'cent_20'
			label = "20 centesimi"
		TYPE.CENT_50:
			texture_name = 'cent_50'
			label = "50 centesimi"
		TYPE.EUR_1:
			texture_name = 'eur_1'
			label = "1 euro"
		TYPE.EUR_2:
			texture_name = 'eur_2'
			label = "2 euro"
		
	name_label.text = label
	texture_rect.texture = load(gui_textures[texture_name])
	add_to_group("coin_control")

func _on_MinusButton_pressed() -> void:
	self.coin_count = max(0, coin_count-1)
	$AudioMinus.play()

func _on_PlusButton_pressed() -> void:
	self.coin_count += 1
	$AudioPlus.play()

func set_coin_count(value: int) -> void:
	coin_count = value
	count_label.text = str(coin_count)
	emit_signal("coin_count_changed", type, coin_count)

func get_type() -> int:
	return type

func get_coin_count() -> int:
	return coin_count
