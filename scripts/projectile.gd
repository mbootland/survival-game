extends CSGBox3D

var velocity := Vector3.ZERO
var speed := 5.0
var lifetime := 0.0
const MAX_LIFETIME := 4.0
const HIT_DISTANCE := 2.0
var player: CharacterBody3D

func set_direction(direction: Vector3, projectile_speed: float) -> void:
	velocity = direction * projectile_speed
	speed = projectile_speed

func set_target(target: CharacterBody3D) -> void:
	player = target

func _physics_process(delta: float) -> void:
	lifetime += delta
	
	if lifetime >= MAX_LIFETIME:
		print("Projectile lifetime expired: ", lifetime)
		queue_free()
		return
	
	if velocity != Vector3.ZERO:
		global_position += velocity * delta
		
		if player:
			var distance = global_position.distance_to(player.global_position)
			print("Distance to player: ", distance, " | Projectile pos: ", global_position, " | Player pos: ", player.global_position)
			if distance < HIT_DISTANCE:
				print("HIT! Projectile destroyed at distance: ", distance)
				queue_free()
