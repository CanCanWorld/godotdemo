extends CanvasLayer
class_name EndUi
@onready var label: Label = %Label
@onready var button: Button = %Button
var is_success = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_success:
		label.text = "你过关！"
	else :
		label.text = "你失败！"
	pass


func _on_button_pressed() -> void:
	pass # Replace with function body.
