extends Node2D
class_name RotateBall

@onready var ball_tscn = preload("res://skill/rotateBall/ball/ball.tscn")

var ball_num = 1
var ball_radius = 140
var speed = 10
var row = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_ball()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i : Ball in get_children():
		i.position = i.position.rotated(2 * PI / 1000 * speed)
		i.rotation = i.rotation + 2 * PI / 1000 * speed
	pass
	
func add_ball():
	for i : Ball in get_children():
		remove_child(i)
	for r in row:
		for i in ball_num: 
			var position = Vector2(ball_radius * (r + 1) , 0).rotated(2 * PI / ball_num * i)
			var ball_ins : Ball = ball_tscn.instantiate()
			ball_ins.position = position
			ball_ins.rotation = 2 * PI / ball_num * i
			add_child(ball_ins)
