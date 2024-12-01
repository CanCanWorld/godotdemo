extends BaseNode2D
class_name Trap

@onready var vortex_tscn = preload("res://skill/trap/vortex/vortex.tscn")
@onready var cd_timer : Timer = $cd

var enemise : Array[Enemy] = []
var hand_num = 1
var now_vortex : Vortex
var duration = 15
var vortex_scale_ratio = scale.x
var vortex_attack_speed_ratio = 1

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func set_cd(ratio):
	cd_timer.wait_time = cd_timer.wait_time * ratio

func set_big(ratio):
	vortex_scale_ratio *= ratio

func set_attack_speed(ratio):
	vortex_attack_speed_ratio *= ratio

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemise.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemise.pop_at(enemise.find(body))

func _on_cd_timeout() -> void:
	if enemise.size() == 0:
		return
	enemise.sort_custom(
		func(a : Enemy, b : Enemy):
			return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position)
	)
	print("释放陷阱")
	var vortex : Vortex = vortex_tscn.instantiate()
	get_tree().root.add_child(vortex)
	vortex.set_attack_speed(vortex_attack_speed_ratio)
	vortex.set_big(vortex_scale_ratio)
	now_vortex = vortex
	vortex.global_position = enemise[0].global_position
	await get_tree().create_timer(duration).timeout
	get_tree().root.remove_child(vortex)
