# res://Scripts/Classes/Utilies/Log.gd
class_name Log
extends RefCounted

# template -> last args key
static var _last_by_template: Dictionary = {}
static var _max_templates := 512
static var disable := false

# Prints only when the args change for the same template.
# Template uses {0}, {1}, ... placeholders (String.format style).
static func ln(template: String, ...args) -> void:
	if disable:
		return
	var key := _make_args_key(args)

	if (not _last_by_template.has(template)) or (_last_by_template[template] != key):
		_last_by_template[template] = key
		_evict_if_needed()
		
		print(template.format(args))

static func reset(template: String = "") -> void:
	if template == "":
		_last_by_template.clear()
	else:
		_last_by_template.erase(template)

static func _make_args_key(args: Array) -> String:
	var parts: PackedStringArray = []
	parts.resize(args.size())
	for i in args.size():
		parts[i] = var_to_str(args[i])
	return "|".join(parts)

static func _evict_if_needed() -> void:
	if _last_by_template.size() <= _max_templates:
		return
	_last_by_template.erase(_last_by_template.keys()[0])
