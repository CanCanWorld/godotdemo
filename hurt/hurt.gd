extends Node2D
class_name HurtText

@onready var hurt_text = $text
@onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_text(text: String):
	hurt_text.text = text
	anim.play("default")


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
