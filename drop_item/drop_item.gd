extends CharacterBody2D

class_name DropItem

var player: Node2D
var isMoving = false
var speed = 600

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isMoving:
		var dir = (player.global_position - position).normalized()
		velocity = dir * speed
		move_and_slide()
	pass


"""
options.box 动画父级
options.ani_name 动画名称
options.position 动画生成位置
options.scale 动画缩放
"""
func create_drop_item(options):
	var drop_item = duplicate() as Node2D
	options.box.add_child(drop_item)
	drop_item.scale = options.scale if options.has("scale") else Vector2.ONE
	drop_item.position = options.position
	var ani = drop_item.get_node("anim") as AnimatedSprite2D
	ani.play(options.ani_name)
	pass
