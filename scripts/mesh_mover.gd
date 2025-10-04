extends Node3D

const SPEED := 2.0
@onready var player: CharacterBody3D = $"../Player"


func _process(delta: float) -> void:
	print(position)
	var direction = (player.global_position - global_position).normalized()
	position += direction * SPEED * delta
