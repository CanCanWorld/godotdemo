extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_1_pressed() -> void:
	hide()
	get_tree().paused = false
	pass # Replace with function body.


func _on_btn_2_pressed() -> void:
	hide()
	get_tree().paused = false
	pass # Replace with function body.


func _on_btn_3_pressed() -> void:
	hide()
	get_tree().paused = false
	pass # Replace with function body.
