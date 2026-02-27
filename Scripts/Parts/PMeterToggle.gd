class_name PMeterToggle
extends Node2D

@export var enable_p_meter := true

var _original_p_meter_enabled := false

func _ready() -> void:
	if is_instance_valid(Global.current_level):
		_original_p_meter_enabled = Global.current_level.p_meter_enabled
		Global.current_level.p_meter_enabled = enable_p_meter

func _exit_tree() -> void:
	if is_instance_valid(Global.current_level):
		Global.current_level.p_meter_enabled = _original_p_meter_enabled
