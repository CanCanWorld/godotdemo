extends Node

@onready var anim_tscn = preload("res://animations/animations.tscn")
@onready var anim: Animations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim = anim_tscn.instantiate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
