class_name PMeterSetter
extends Node2D

@export_range(0, 100) var p_power_amount := 0

signal p_power_full
signal p_power_empty

func _ready() -> void:
	for player: Player in get_tree().get_nodes_in_group("Players"):
		apply_to_player(player)
		player.p_meter_filled.connect(func(): p_power_full.emit())
		player.p_meter_emptied.connect(func(): p_power_empty.emit())

func apply_to_player(player: Player) -> void:
	player.p_meter = float(p_power_amount) / 100.0
	player.p_meter_full = player.p_meter >= 1.0
