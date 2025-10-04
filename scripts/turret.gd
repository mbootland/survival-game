extends Node3D

const SPEED := 10.0
const FIRE_RATE := 2.0

var time_since_last_shot := 0.0
var projectile_scene = preload("uid://2iw02qoepmxe")
@onready var player: CharacterBody3D = $"../Player"

func _physics_process(delta: float) -> void:
	if not player:
		return
		
	time_since_last_shot += delta
	
	if time_since_last_shot >= FIRE_RATE:
		fire_projectile()
		time_since_last_shot = 0.0

func fire_projectile() -> void:
	var new_projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(new_projectile)
	new_projectile.global_position = global_position
	
	var direction = (player.global_position - global_position).normalized()
	
	if new_projectile.has_method("set_direction"):
		new_projectile.set_direction(direction, SPEED)
	if new_projectile.has_method("set_target"):
		new_projectile.set_target(player)
