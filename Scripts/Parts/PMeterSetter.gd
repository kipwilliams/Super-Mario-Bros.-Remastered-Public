class_name PMeterSetter
extends Node2D

enum Operation { SET_TO, SET_FULL, SET_EMPTY, INCREASE_BY, DECREASE_BY }

@export var operation: Operation = Operation.SET_TO
## Amount of P power (0-100%). Only used by SET_TO, INCREASE_BY, and DECREASE_BY operations.
@export_range(0, 100) var p_power_amount := 0

signal p_power_full
signal p_power_empty

func _ready() -> void:
	for player: Player in get_tree().get_nodes_in_group("Players"):
		apply_to_player(player)
		player.p_meter_filled.connect(func(): p_power_full.emit())
		player.p_meter_emptied.connect(func(): p_power_empty.emit())

func apply_to_player(player: Player) -> void:
	var amount := float(p_power_amount) / 100.0
	match operation:
		Operation.SET_FULL:
			player.p_meter = 1.0
		Operation.SET_EMPTY:
			player.p_meter = 0.0
		Operation.INCREASE_BY:
			player.p_meter = min(player.p_meter + amount, 1.0)
		Operation.DECREASE_BY:
			player.p_meter = max(player.p_meter - amount, 0.0)
		Operation.SET_TO:
			player.p_meter = amount
	player.p_meter_full = player.p_meter >= 1.0
