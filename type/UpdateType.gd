extends Object
class_name UpdateType

var title : String = ""

var desc : String = ""

var callback : Callable

func _init(title: String, desc: String, callback : Callable) -> void:
	self.title = title
	self.desc = desc
	self.callback = callback
	pass
