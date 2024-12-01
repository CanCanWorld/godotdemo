extends BaseNode2D
class_name Vortex

@onready var area = $Area2D
@onready var timer: Timer = $Timer

var enemise : Array[Enemy] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass
	
func set_big(ratio):
	print("变大", ratio)
	scale *= ratio
	
func set_attack_speed(ratio):
	print("变快", ratio)
	timer.wait_time *= ratio
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		enemise.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Enemy:
		enemise.pop_at(enemise.find(body))

func _on_timer_timeout() -> void:
	for enemy in enemise:
		enemy.hurted(20 + player.attack / 10, position, true)
	pass # Replace with function body.
