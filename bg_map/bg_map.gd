extends Node2D

@onready var tileMap: TileMap = $TileMap
@onready var start = $start
@onready var prepare = $prepare

func _ready() -> void:
	#random_tile()
	start.show()
	#prepare.show()
	pass


func _process(delta: float) -> void:
	pass
	
func random_tile():
	tileMap.clear_layer(1)
	var cells = tileMap.get_used_cells(0)
	var random = RandomNumberGenerator.new()
	for cell in cells:
		var randi = random.randf_range(0, 100)
		print(randi)
		if randi < 2:
			tileMap.set_cell(1, cell, 0, Vector2i(6, 0))
		elif randi < 4:
			tileMap.set_cell(1, cell, 0, Vector2i(5, 1))
		elif randi < 6:
			tileMap.set_cell(1, cell, 0, Vector2i(6, 1))
		elif randi < 6.5:
			tileMap.set_cell(1, cell, 0, Vector2i(5, 2))
		elif randi < 7:
			tileMap.set_cell(1, cell, 0, Vector2i(6, 2))
		pass
