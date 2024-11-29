extends Node2D
class_name Animations

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

"""
options.box 动画父级
options.ani_name 动画名称
options.position 动画生成位置
options.scale 动画缩放
"""
func play_anim(options):
	var ani_temp = duplicate() as Node2D
	options.box.add_child(ani_temp)
	ani_temp.show()
	ani_temp.scale = options.scale if options.has("scale") else Vector2.ONE
	ani_temp.position = options.position
	var ani = ani_temp.get_node("all_animations") as AnimatedSprite2D
	ani.play(options.ani_name)
	pass


func _on_all_animations_animation_finished() -> void:
	queue_free()
