extends CanvasLayer
class_name SceneUpdate

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

var option1 : UpdateType
var option2 : UpdateType
var option3 : UpdateType


var default_update_list : Array[UpdateType] = [
	UpdateType.new("血量上限", "血量增加200点", Callable(self, "hp_up")),
	UpdateType.new("攻击力", "攻击力增加40点", Callable(self, "attack_up")),
	UpdateType.new("移动速度", "移动速度增加10%", Callable(self, "speed_up")),
	UpdateType.new("回复", "每秒恢复最大生命的1%", Callable(self, "hp_recovery")),
]

var updateList : Array[UpdateType] = default_update_list

var ji_update_list : Array[UpdateType] = [
	UpdateType.new("影响力增加", "明星气场的攻击范围增大10%", Callable(self, "bomb_big")),
	UpdateType.new("明星的代价", "明星气场的击杀会增加2点基础血量，降低1点基础攻击力", Callable(self, "bomb_hp")),
	UpdateType.new("卷起来了", "明星气场的攻击频率提高10%", Callable(self, "bomb_fps")),
]

var wang_update_list = []

var shan_update_list = [
	UpdateType.new("长长长", "增加大刀的长度10%", Callable(self, "chop_scale")),
	UpdateType.new("强强强", "大刀击杀将增加基础攻击力1点", Callable(self, "chop_add_attack")),
	UpdateType.new("抗抗抗", "大刀击杀将增加基础血量1点", Callable(self, "chop_add_hp")),
]

var wang2_update_list = [
	UpdateType.new("量变引起质变", "增加一个暗影球", Callable(self, "add_dark_ball_num")),
	UpdateType.new("指数增加，小子", "增加一排暗影球", Callable(self, "add_dark_ball_row")),
	UpdateType.new("这有什么用？", "增加暗影球的移动速度10%", Callable(self, "add_dark_ball_speed")),
]

var me_update_list : Array[UpdateType] = []

func chooseJi():
	updateList.append_array(ji_update_list)
func chooseWang():
	updateList.append_array(wang_update_list)
func chooseShan():
	updateList.append_array(shan_update_list)
func chooseWang2():
	updateList.append_array(wang2_update_list)
func chooseMe():
	updateList.append_array(me_update_list)


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
	print("大刀，范围")
	var chop : Chop = player.get_node("chop")
	chop.now_scale *= 1.1
	
func chop_add_attack():
	print("大刀，加伤")
	var chop : Chop = player.get_node("chop")
	chop.add_attack += 1
	
func chop_add_hp():
	print("大刀，加血")
	var chop : Chop = player.get_node("chop")
	chop.add_hp += 1

func bomb_big():
	var bomb : Bomb = player.get_node("bomb")
	bomb.big(1.1)
	
func bomb_hp():
	var bomb : Bomb = player.get_node("bomb")
	bomb.add_hp += 2
	bomb.add_attack -= 1
	
func bomb_fps():
	var bomb : Bomb = player.get_node("bomb")
	bomb.fast(1.1)
	
