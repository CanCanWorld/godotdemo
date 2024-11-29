extends Node2D

@onready var tileMap: TileMap = $TileMap
@onready var start = $start
@onready var prepare = $prepare

func _ready() -> void:
	start.show()
	prepare.show()
	pass


func _process(delta: float) -> void:
	pass
