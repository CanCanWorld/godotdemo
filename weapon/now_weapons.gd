extends Node2D

var radiu = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var weapons_count = get_child_count()
	#计算弧度
	var unit_angle = 2 * PI / weapons_count
	for i in weapons_count:
		var child :Node2D = get_child(i)
		child.position = Vector2(radiu, 0).rotated(unit_angle * i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
