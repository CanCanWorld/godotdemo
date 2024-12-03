extends Node2D

@onready var anim : AnimatedSprite2D = $AnimatableBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	anim.flip_h = get_global_mouse_position().x - global_position.x < 0
	pass