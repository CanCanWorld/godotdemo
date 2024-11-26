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
	UpdateType.new("血量上限", "血量增加200点", Callable(self, "hp_up")),
	UpdateType.new("攻击力", "攻击力增加40点", Callable(self, "attack_up")),
	UpdateType.new("移动速度", "移动速度增加10%", Callable(self, "speed_up")),
	UpdateType.new("回复", "每秒恢复最大生命的1%", Callable(self, "hp_recovery")),
	UpdateType.new("暗影球", "增加一个暗影球，暗影球造成20的基础伤害+10%角色攻击力的伤害，并回复造成伤害的1%血量", Callable(self, "add_dark_ball_num")),
	UpdateType.new("暗影球", "增加一排暗影球", Callable(self, "add_dark_ball_row")),
	UpdateType.new("暗影球", "增加暗影球的移动速度20%", Callable(self, "add_dark_ball_speed")),
	UpdateType.new("劈砍", "增加劈砍范围20%", Callable(self, "chop_scale")),
	UpdateType.new("劈砍", "劈砍击杀将增加基础攻击力1点", Callable(self, "chop_add_attack")),
	UpdateType.new("劈砍", "劈砍击杀将增加基础血量1点", Callable(self, "chop_add_hp")),
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
	player.add_max_hp(200)
	pass

func attack_up(): 
	print("加攻")
	player.attack += 40
	pass

func speed_up(): 
	print("加速")
	player.speed *= 1.1
	pass

func hp_recovery():
	print("恢复")
	var instant = hp_recovery_tscn.instantiate()
	player.add_child(instant)

func add_dark_ball_num():
	print("暗黑球，加个")
	var rotate_ball : RotateBall = player.get_node("rotate_ball")
	rotate_ball.ball_num += 1
	rotate_ball.add_ball()

func add_dark_ball_row():
	print("暗黑球，加排")
	var rotate_ball : RotateBall = player.get_node("rotate_ball")
	rotate_ball.row += 1
	rotate_ball.add_ball()

func add_dark_ball_speed():
	print("暗黑球，加速")
	var rotate_ball : RotateBall = player.get_node("rotate_ball")
	print("暗黑球", rotate_ball.ball_num)
	rotate_ball.speed = int(rotate_ball.speed * 1.2)
	rotate_ball.add_ball()
	
func chop_scale():
	print("暗黑球，范围")
	var chop : Chop = player.get_node("chop")
	chop.now_scale *= 1.2
	
func chop_add_attack():
	print("劈砍，加伤")
	var chop : Chop = player.get_node("chop")
	chop.add_attack += 1
	
func chop_add_hp():
	print("，加血")
	var chop : Chop = player.get_node("chop")
	chop.add_hp += 1
	
