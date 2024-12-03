extends Node

@onready var anim_tscn = preload("res://animations/animations.tscn")
@onready var anim : Animations
@onready var drop_item_tscn = preload("res://drop_item/drop_item.tscn")
@onready var drop_item : DropItem

var game_time = 600
var now_game_time = game_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim = anim_tscn.instantiate()
	drop_item = drop_item_tscn.instantiate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
