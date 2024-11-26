extends BaseNode2D
class_name Chop

@onready var anim = $anim
@onready var area = $area
@onready var anim_player = $AnimationPlayer
var base_hurt = 200
var hurt = base_hurt
var add_attack = 0
var add_hp = 0
var now_scale = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	anim.hide()
	area.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hurt = base_hurt + player.attack
	scale = Vector2(now_scale, now_scale)
	position = (get_global_mouse_position() - player.global_position).normalized() * 100
	look_at(get_global_mouse_position())
	pass


func _on_timer_timeout() -> void:
	print("劈砍")
	anim.show()
	area.show()
	anim.play()
	anim_player.play("attack")
	area.monitoring = true
	await get_tree().create_timer(0.4).timeout
	anim_player.play("RESET")
	area.monitoring = false
	anim.hide()
	area.hide()
	pass # Replace with function body.

func _on_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("enemy"):
		var enemy = body as Enemy
		var isDead = await enemy.hurted(hurt, global_position)
		if isDead:
			player.add_max_hp(add_hp)
			player.attack += add_attack
	pass # Replace with function body.
