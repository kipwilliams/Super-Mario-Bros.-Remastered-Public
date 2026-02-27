extends Node

@export var grab_enabled := true
@export_enum("ForwardOnly", "ForwardAndUp") var throw_style := 0

func _ready() -> void:
	if Global.current_level != null:
		Global.current_level.item_grab_enabled = grab_enabled
		Global.current_level.item_throw_style = throw_style
