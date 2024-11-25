extends CanvasLayer

@onready var title1 : Label = %title1
@onready var title2 : Label = %title2
@onready var title3 : Label = %title3
@onready var desc1 : Label = %desc1
@onready var desc2 : Label = %desc2
@onready var desc3 : Label = %desc3
@onready var button1 : Button = %button1
@onready var button2 : Button = %button2
@onready var button3 : Button = %button3
@onready var hp_recovery_tscn = preload("res://skill/hpRecovery/hp_recovery.tscn")

var player: Player

var updateList : Array[UpdateType] = [
	UpdateType.new("血量上限", "血量增加20点", Callable(self, "hp_up")),
	UpdateType.new("攻击力", "攻击力增加4点", Callable(self, "attack_up")),
	UpdateType.new("移动速度", "移动速度增加10%", Callable(self, "speed_up")),
	UpdateType.new("回复", "每秒恢复最大生命的1%", Callable(self, "hp_recovery")),
]
var option1 : UpdateType
var option2 : UpdateType
var option3 : UpdateType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_1_pressed() -> void:
	get_tree().paused = false
	hide()
	print("1选择了", option1.title)
	option1.callback.call()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	get_tree().paused = false
	hide()
	print("2选择了", option2.title)
	option2.callback.call()
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	get_tree().paused = false
	hide()
	print("3选择了", option3.title)
	option3.callback.call()
	pass # Replace with function body.


func _on_visibility_changed() -> void:
	if visible:
		print("升级了")
		update()
	pass # Replace with function body.

func update(): 
	updateList.shuffle()
	print("1", updateList[0].title)
	print("2", updateList[1].title)
	print("3", updateList[2].title)
	option1 = updateList[0]
	option2 = updateList[1]
	option3 = updateList[2]
	title1.text = option1.title
	title2.text = option2.title
	title3.text = option3.title
	desc1.text = option1.desc
	desc2.text = option2.desc
	desc3.text = option3.desc
	pass

func hp_up(): 
	print("加血")
	player.max_hp += 20
	player.hp += 20
	pass

func attack_up(): 
	print("加攻")
	player.attack += 4
	pass

func speed_up(): 
	print("加速")
	player.speed *= 1.1
	pass

func hp_recovery():
	print("恢复")
	var instant = hp_recovery_tscn.instantiate()
	player.add_child(instant)
