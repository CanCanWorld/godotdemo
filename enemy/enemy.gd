extends CharacterBody2D
class_name Enemy

var dir = Vector2.ONE
var speed = 100
var player : Node2D = null
@onready var anim = $AnimatedSprite2D
var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dir = (player.global_position - global_position).normalized()
	velocity = dir * speed
	anim.flip_h = dir.x < 0
	move_and_slide()
	pass
