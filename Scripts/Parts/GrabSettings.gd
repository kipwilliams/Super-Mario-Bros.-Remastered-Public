extends Node2D

@export var grab_enabled := true
@export_enum("ForwardOnly", "ForwardAndUp") var throw_style := 0

func _ready() -> void:
	_apply_settings()
	var exposer := get_node_or_null("EditorPropertyExposer")
	if exposer:
		exposer.modifier_applied.connect(_apply_settings)

func _apply_settings() -> void:
	if Global.current_level != null:
		Global.current_level.item_grab_enabled = grab_enabled
		Global.current_level.item_throw_style = throw_style
