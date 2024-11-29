extends Node2D
class_name RecoveryText

@onready var recovery_text = $text
@onready var anim = $AnimationPlayer
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass

func set_text(text: String):
	recovery_text.text = "+" + text
	anim.play("default")


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
