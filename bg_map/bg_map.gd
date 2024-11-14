extends Node2D

@onready var tileMap = $TileMap

func _ready() -> void:
	random_tile()
	pass


func _process(delta: float) -> void:
	pass
	
func random_tile():
	tileMap.clear_layer(1)
	var cells = tileMap.get_used_cells(0)
	var random = RandomNumberGenerator.new()
	for cell in cells:
		var randi = random.randi_range(0, 100)
		if randi < 2:
			tileMap.set_cell(1, cell, 0, Vector2i(5, 0))
		elif randi < 4:
			tileMap.set_cell(1, cell, 0, Vector2i(5, 1))
		elif randi < 6:
			tileMap.set_cell(1, cell, 0, Vector2i(5, 2))
		elif randi < 8:
			tileMap.set_cell(1, cell, 0, Vector2i(6, 1))
		elif randi < 10:
			tileMap.set_cell(1, cell, 0, Vector2i(6, 2))
		pass
